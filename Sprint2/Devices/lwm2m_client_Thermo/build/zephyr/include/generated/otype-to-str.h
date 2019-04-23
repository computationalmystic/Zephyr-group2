/* Core kernel objects */
case K_OBJ_MEM_SLAB: ret = "k_mem_slab"; break;
case K_OBJ_MSGQ: ret = "k_msgq"; break;
case K_OBJ_MUTEX: ret = "k_mutex"; break;
case K_OBJ_PIPE: ret = "k_pipe"; break;
case K_OBJ_QUEUE: ret = "k_queue"; break;
case K_OBJ_POLL_SIGNAL: ret = "k_poll_signal"; break;
case K_OBJ_SEM: ret = "k_sem"; break;
case K_OBJ_STACK: ret = "k_stack"; break;
case K_OBJ_THREAD: ret = "k_thread"; break;
case K_OBJ_TIMER: ret = "k_timer"; break;
case K_OBJ__THREAD_STACK_ELEMENT: ret = "_k_thread_stack_element"; break;
#ifdef CONFIG_NETWORKING
case K_OBJ_NET_CONTEXT: ret = "net_context"; break;
#endif
/* Driver subsystems */
case K_OBJ_DRIVER_ADC: ret = "adc driver"; break;
case K_OBJ_DRIVER_AIO_CMP: ret = "aio_cmp driver"; break;
case K_OBJ_DRIVER_COUNTER: ret = "counter driver"; break;
case K_OBJ_DRIVER_CRYPTO: ret = "crypto driver"; break;
case K_OBJ_DRIVER_DMA: ret = "dma driver"; break;
case K_OBJ_DRIVER_FLASH: ret = "flash driver"; break;
case K_OBJ_DRIVER_GPIO: ret = "gpio driver"; break;
case K_OBJ_DRIVER_I2C: ret = "i2c driver"; break;
case K_OBJ_DRIVER_I2S: ret = "i2s driver"; break;
case K_OBJ_DRIVER_IPM: ret = "ipm driver"; break;
case K_OBJ_DRIVER_LED: ret = "led driver"; break;
case K_OBJ_DRIVER_PINMUX: ret = "pinmux driver"; break;
case K_OBJ_DRIVER_PWM: ret = "pwm driver"; break;
case K_OBJ_DRIVER_ENTROPY: ret = "entropy driver"; break;
case K_OBJ_DRIVER_RTC: ret = "rtc driver"; break;
case K_OBJ_DRIVER_SENSOR: ret = "sensor driver"; break;
case K_OBJ_DRIVER_SPI: ret = "spi driver"; break;
case K_OBJ_DRIVER_UART: ret = "uart driver"; break;
case K_OBJ_DRIVER_CAN: ret = "can driver"; break;
