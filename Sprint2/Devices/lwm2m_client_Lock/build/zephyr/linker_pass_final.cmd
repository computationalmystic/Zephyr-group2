MEMORY
    {
    ROM (rx) : ORIGIN = 0x1000, LENGTH = 4092*1K
    RAM (wx) : ORIGIN = 0x400000, LENGTH = 8188*1K
    IDT_LIST : ORIGIN = 0xFFFF1000, LENGTH = 2K
    MMU_LIST : ORIGIN = 0xFFFF2000, LENGTH = 1K
    }
  OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
  OUTPUT_ARCH("i386")
ENTRY("__start")
SECTIONS
 {
 .rel.plt :
 {
 *(.rel.plt)
 PROVIDE_HIDDEN (__rel_iplt_start = .);
 *(.rel.iplt)
 PROVIDE_HIDDEN (__rel_iplt_end = .);
 }
 .rela.plt :
 {
 *(.rela.plt)
 PROVIDE_HIDDEN (__rela_iplt_start = .);
 *(.rela.iplt)
 PROVIDE_HIDDEN (__rela_iplt_end = .);
 }
 .rel.dyn :
 {
 *(.rel.*)
 }
 .rela.dyn :
 {
 *(.rela.*)
 }
    /DISCARD/ :
 {
 *(.plt)
 }
    /DISCARD/ :
 {
 *(.iplt)
 }

 . = ALIGN(8);
 _image_rom_start = 0x1000;
 _image_text_start = 0x1000;
 text :
 {
 . = 0x0;
 *(.text_start)
 *(".text_start.*")
 *(.text)
 *(".text.*")
 *(.gnu.linkonce.t.*)
 *(.eh_frame_hdr)
 *(.eh_frame)
 *(.init)
 *(.fini)
 *(.eini)
 KEEP(*(.openocd_dbg))
 KEEP(*(".openocd_dbg.*"))
 . = ALIGN(((4) << 10));
 } > ROM
 _image_text_end = .;
 _image_text_size = _image_text_end - _image_text_start;
 _image_rodata_start = .;
 app_shmem_regions :
 {
  __app_shmem_regions_start = .;
  KEEP(*(SORT(".app_regions.*")));
  __app_shmem_regions_end = .;
 } > ROM
 devconfig :
 {
  __devconfig_start = .;
  *(".devconfig.*")
  KEEP(*(SORT(".devconfig*")))
  __devconfig_end = .;
 } > ROM
 net_l2 :
 {
  __net_l2_start = .;
  *(".net_l2.init")
  KEEP(*(SORT(".net_l2.init*")))
  __net_l2_end = .;
 } > ROM
 log_const_sections : ALIGN_WITH_INPUT
 {
  __log_const_start = .;
  KEEP(*(SORT(.log_const_*)));
  __log_const_end = .;
 } > ROM
 log_backends_sections : ALIGN_WITH_INPUT
 {
  __log_backends_start = .;
  KEEP(*(".log_backends"));
  __log_backends_end = .;
 } > ROM
 shell_root_cmds_sections : ALIGN_WITH_INPUT
 {
  __shell_root_cmds_start = .;
  KEEP(*(SORT(.shell_root_cmd_*)));
  __shell_root_cmds_end = .;
 } > ROM
 font_entry_sections : ALIGN_WITH_INPUT
 {
  __font_entry_start = .;
  KEEP(*(SORT(".font_entry.*")))
  __font_entry_end = .;
 } > ROM
 rodata :
 {
 *(.rodata)
 *(".rodata.*")
 *(.gnu.linkonce.r.*)
 . = ALIGN(8);
 _idt_base_address = .;
 KEEP(*(staticIdt))
 . = ALIGN(4);
 _irq_to_interrupt_vector = .;
 KEEP(*(irq_int_vector_map))
 } > ROM
 . = ALIGN(((4) << 10));
 _image_rom_end = _image_rom_start + ((4092) << 10);
 _image_rom_size = _image_rom_end - _image_rom_start;
 _image_rodata_end = _image_rom_end;
 _image_rodata_size = _image_rodata_end - _image_rodata_start;

 /DISCARD/ : {
  *(.got.plt)
  *(.igot.plt)
  *(.got)
  *(.igot)
 }

 bss (NOLOAD) :
 {
 . = ALIGN(((4) << 10));
 _image_ram_start = .;
 . = ALIGN(4);
 __kernel_ram_start = .;
 __bss_start = .;
 *(.bss)
 *(".bss.*")
 *(COMMON)
 *(".kernel_bss.*")
 . = ALIGN(4);
 __bss_end = .;
 } > RAM AT> RAM
 __bss_num_words = (__bss_end - __bss_start) >> 2;
 noinit (NOLOAD) :
 {
 *(.noinit)
 *(".noinit.*")
 *(".kernel_noinit.*")
 . = ALIGN(((4) << 10));
 } > RAM AT> RAM
 datas : ALIGN_WITH_INPUT
 {
 __data_ram_start = .;
 *(.data)
 *(".data.*")
 *(".kernel.*")
 . = ALIGN(4);
 } > RAM AT> ROM
 __data_rom_start = LOADADDR(datas);
 initlevel : ALIGN_WITH_INPUT
 {
  __device_init_start = .; __device_PRE_KERNEL_1_start = .; KEEP(*(SORT(.init_PRE_KERNEL_1[0-9]))); KEEP(*(SORT(.init_PRE_KERNEL_1[1-9][0-9]))); __device_PRE_KERNEL_2_start = .; KEEP(*(SORT(.init_PRE_KERNEL_2[0-9]))); KEEP(*(SORT(.init_PRE_KERNEL_2[1-9][0-9]))); __device_POST_KERNEL_start = .; KEEP(*(SORT(.init_POST_KERNEL[0-9]))); KEEP(*(SORT(.init_POST_KERNEL[1-9][0-9]))); __device_APPLICATION_start = .; KEEP(*(SORT(.init_APPLICATION[0-9]))); KEEP(*(SORT(.init_APPLICATION[1-9][0-9]))); __device_init_end = .;
 } > RAM AT> ROM
 initlevel_error : ALIGN_WITH_INPUT
 {
  KEEP(*(SORT(.init_[_A-Z0-9]*)))
 }
 ASSERT(SIZEOF(initlevel_error) == 0, "Undefined initialization levels used.")
 initshell : ALIGN_WITH_INPUT
 {
  __shell_module_start = .; KEEP(*(".shell_module_*")); __shell_module_end = .; __shell_cmd_start = .; KEEP(*(".shell_cmd_*")); __shell_cmd_end = .;
 } > RAM AT> ROM
 log_dynamic_sections : ALIGN_WITH_INPUT
 {
  __log_dynamic_start = .;
  KEEP(*(SORT(.log_dynamic_*)));
  __log_dynamic_end = .;
 } > RAM AT> ROM
 _static_thread_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _static_thread_data_list_start = .;
  KEEP(*(SORT("._static_thread_data.static.*")))
  _static_thread_data_list_end = .;
 } > RAM AT> ROM
 _k_timer_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_timer_list_start = .;
  KEEP(*("._k_timer.static.*"))
  _k_timer_list_end = .;
 } > RAM AT> ROM
 _k_mem_slab_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_mem_slab_list_start = .;
  KEEP(*("._k_mem_slab.static.*"))
  _k_mem_slab_list_end = .;
 } > RAM AT> ROM
 _k_mem_pool_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_mem_pool_list_start = .;
  KEEP(*("._k_mem_pool.static.*"))
  _k_mem_pool_list_end = .;
 } > RAM AT> ROM
 _k_sem_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_sem_list_start = .;
  KEEP(*("._k_sem.static.*"))
  _k_sem_list_end = .;
 } > RAM AT> ROM
 _k_mutex_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_mutex_list_start = .;
  KEEP(*("._k_mutex.static.*"))
  _k_mutex_list_end = .;
 } > RAM AT> ROM
 _k_queue_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_queue_list_start = .;
  KEEP(*("._k_queue.static.*"))
  _k_queue_list_end = .;
 } > RAM AT> ROM
 _k_stack_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_stack_list_start = .;
  KEEP(*("._k_stack.static.*"))
  _k_stack_list_end = .;
 } > RAM AT> ROM
 _k_msgq_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_msgq_list_start = .;
  KEEP(*("._k_msgq.static.*"))
  _k_msgq_list_end = .;
 } > RAM AT> ROM
 _k_mbox_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_mbox_list_start = .;
  KEEP(*("._k_mbox.static.*"))
  _k_mbox_list_end = .;
 } > RAM AT> ROM
 _k_pipe_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _k_pipe_list_start = .;
  KEEP(*("._k_pipe.static.*"))
  _k_pipe_list_end = .;
 } > RAM AT> ROM
 _net_buf_pool_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _net_buf_pool_list = .;
  KEEP(*(SORT("._net_buf_pool.static.*")))
 } > RAM AT> ROM
 net_if : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  __net_if_start = .;
  *(".net_if.*")
  KEEP(*(SORT(".net_if.*")))
  __net_if_end = .;
 } > RAM AT> ROM
 net_if_dev : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  __net_if_dev_start = .;
  *(".net_if_dev.*")
  KEEP(*(SORT(".net_if_dev.*")))
  __net_if_dev_end = .;
 } > RAM AT> ROM
 net_stack : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  __net_stack_start = .;
  *(".net_stack.*")
  KEEP(*(SORT(".net_stack*")))
  __net_stack_end = .;
 } > RAM AT> ROM
 net_l2_data : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  __net_l2_data_start = .;
  *(".net_l2.data")
  KEEP(*(SORT(".net_l2.data*")))
  __net_l2_data_end = .;
 } > RAM AT> ROM
 mmu_tables : ALIGN_WITH_INPUT
 {
 . = ALIGN(((4) << 10));
 __mmu_tables_start = .;
 z_x86_kernel_pdpt = .;
 KEEP(*(mmu_tables));
 __mmu_tables_end = .;
 } > RAM AT> ROM
 . = ALIGN(((4) << 10));
 __data_ram_end = .;
 __kernel_ram_end = 0x400000 + ((8188) << 10);
 __kernel_ram_size = __kernel_ram_end - __kernel_ram_start;
 _image_ram_end = .;
 _image_ram_all = (0x400000 + ((8188) << 10)) - _image_ram_start;
 _end = .;

 /DISCARD/ :
 {
 KEEP(*(.spurIsr))
 KEEP(*(.spurNoErrIsr))
 KEEP(*(.intList))
 KEEP(*(.gnu.linkonce.intList.*))
 KEEP(*(.mmulist))
 }
 .stab 0 : { *(.stab) }
 .stabstr 0 : { *(.stabstr) }
 .stab.excl 0 : { *(.stab.excl) }
 .stab.exclstr 0 : { *(.stab.exclstr) }
 .stab.index 0 : { *(.stab.index) }
 .stab.indexstr 0 : { *(.stab.indexstr) }
 .gnu.build.attributes 0 : { *(.gnu.build.attributes .gnu.build.attributes.*) }
 .comment 0 : { *(.comment) }
 .debug 0 : { *(.debug) }
 .line 0 : { *(.line) }
 .debug_srcinfo 0 : { *(.debug_srcinfo) }
 .debug_sfnames 0 : { *(.debug_sfnames) }
 .debug_aranges 0 : { *(.debug_aranges) }
 .debug_pubnames 0 : { *(.debug_pubnames) }
 .debug_info 0 : { *(.debug_info .gnu.linkonce.wi.*) }
 .debug_abbrev 0 : { *(.debug_abbrev) }
 .debug_line 0 : { *(.debug_line .debug_line.* .debug_line_end ) }
 .debug_frame 0 : { *(.debug_frame) }
 .debug_str 0 : { *(.debug_str) }
 .debug_loc 0 : { *(.debug_loc) }
 .debug_macinfo 0 : { *(.debug_macinfo) }
 .debug_weaknames 0 : { *(.debug_weaknames) }
 .debug_funcnames 0 : { *(.debug_funcnames) }
 .debug_typenames 0 : { *(.debug_typenames) }
 .debug_varnames 0 : { *(.debug_varnames) }
 .debug_pubtypes 0 : { *(.debug_pubtypes) }
 .debug_ranges 0 : { *(.debug_ranges) }
 .debug_macro 0 : { *(.debug_macro) }
 /DISCARD/ : { *(.note.GNU-stack) }
 }
__data_size = (__data_ram_end - __data_ram_start);
__data_num_words = (__data_size + 3) >> 2;
