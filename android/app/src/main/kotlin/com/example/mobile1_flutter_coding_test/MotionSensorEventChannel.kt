package com.example.mobile1_flutter_coding_test
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel
import kotlin.math.abs

class MotionSensorEventChannel (private val context: Context) : EventChannel.StreamHandler, SensorEventListener {
    private var events: EventChannel.EventSink? = null
    private lateinit var sensorManager: SensorManager
    private var motionSensor: Sensor? = null
    private val rotationMatrix = FloatArray(9)
    private val orientation = FloatArray(3)
    private val sendArray = FloatArray(2)
    private val threshold = 0.01f

    override fun onListen(
        arguments: Any?,
        events: EventChannel.EventSink?
    ) {
        this.events = events

        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager

        if (sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR) != null) {
            motionSensor = sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR)
            sensorManager.registerListener(this, motionSensor, SensorManager.SENSOR_DELAY_UI)
        }
    }

    override fun onCancel(arguments: Any?) {
        sensorManager.unregisterListener(this)
    }

    override fun onAccuracyChanged(p0: Sensor?, p1: Int) {}

    override fun onSensorChanged(event: SensorEvent?) {
        if (event != null) {
            val rotationVector = event.values

            SensorManager.getRotationMatrixFromVector(rotationMatrix, rotationVector)
            SensorManager.getOrientation(rotationMatrix, orientation)

            var pitch = orientation[1]
            var roll = orientation[2]
//            val yaw = orientation[0]

            pitch = if (abs(pitch) < threshold) 0f else pitch
            roll = if (abs(roll) < threshold) 0f else roll

            if (abs(pitch) > 0f || abs(roll) > 0f) {
                sendArray[0] = roll
                sendArray[1] = -pitch
                events?.success(sendArray)
            }
        }
    }
}