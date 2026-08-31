#
# SPDX-License-Identifier: GPL-2.0-only
#

# Milk-V Duo (CV1800B): one C906 hart entered in S-mode by the board's OpenSBI.
declare_platform(cv1800b-duo KernelPlatformCV1800BDuo PLAT_CV1800B_DUO KernelArchRiscV)

if(KernelPlatformCV1800BDuo)
  declare_seL4_arch(riscv64)
  config_set(KernelRiscVPlatform RISCV_PLAT ${KernelPlatform})
  config_set(KernelPlatformFirstHartID FIRST_HART_ID 0)
  config_set(KernelOpenSBIPlatform OPENSBI_PLATFORM "generic")
  list(APPEND KernelDTSList "tools/dts/cv1800b-duo.dts")
  list(APPEND KernelDTSList "${CMAKE_CURRENT_LIST_DIR}/overlay-cv1800b-duo.dts")
  # `cpus/timebase-frequency` and `riscv,ndev` in the observed board DT.
  declare_default_headers(TIMER_FREQUENCY 25000000 MAX_IRQ 101
                          INTERRUPT_CONTROLLER drivers/irq/riscv_plic0.h)
else()
  unset(KernelPlatformFirstHartID CACHE)
endif()
