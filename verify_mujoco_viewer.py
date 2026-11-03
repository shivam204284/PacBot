import time
import mujoco
import mujoco.viewer

XML = '''
<mujoco>
  <option gravity="0 0 -9.81"/>
  <worldbody>
    <light pos="0 0 3"/>
    <geom type="plane" size="3 3 .1"/>
    <body pos="0 0 1">
      <freejoint/>
      <geom type="box" size=".15 .15 .15"/>
    </body>
  </worldbody>
</mujoco>
'''

model = mujoco.MjModel.from_xml_string(XML)
data = mujoco.MjData(model)
print("Launching MuJoCo viewer for ~15 seconds...")
with mujoco.viewer.launch_passive(model, data) as viewer:
    end = time.time() + 15
    while viewer.is_running() and time.time() < end:
        mujoco.mj_step(model, data)
        viewer.sync()
        time.sleep(model.opt.timestep)
print("MuJoCo viewer test finished.")
