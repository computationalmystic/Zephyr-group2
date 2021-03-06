
/* auto-generated by gen_syscalls.py, don't edit */

#ifndef _ASMLANGUAGE

#include <syscall_list.h>
#include <syscall_macros.h>

#ifdef __cplusplus
extern "C" {
#endif

K_SYSCALL_DECLARE4(K_SYSCALL_SENSOR_ATTR_SET, sensor_attr_set, int, struct device *, dev, enum sensor_channel, chan, enum sensor_attribute, attr, const struct sensor_value *, val)

K_SYSCALL_DECLARE1(K_SYSCALL_SENSOR_SAMPLE_FETCH, sensor_sample_fetch, int, struct device *, dev)

K_SYSCALL_DECLARE2(K_SYSCALL_SENSOR_SAMPLE_FETCH_CHAN, sensor_sample_fetch_chan, int, struct device *, dev, enum sensor_channel, type)

K_SYSCALL_DECLARE3(K_SYSCALL_SENSOR_CHANNEL_GET, sensor_channel_get, int, struct device *, dev, enum sensor_channel, chan, struct sensor_value *, val)

#ifdef __cplusplus
}
#endif

#endif
