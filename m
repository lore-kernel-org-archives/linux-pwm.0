Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440663CB2F8;
	Fri, 24 Jul 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882579; cv=none; b=MQqtxKcqmLwQtXNXgZwl46Qv3yL+UTV+PvkHmx352igCaYgJF+vZE3tx4sGwXBFjey1rXIvd4Z3G5hzZUd7KRVQQMAgXzasHfDwh6iiPLrwaPT/cgxJS/nstCHQ/MJqfjO+HsPzuFYOUhiogy6cVWXA5quIJ2f6WfvBv2DqcyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882579; c=relaxed/simple;
	bh=DuMepCIB+g3wSFNhhqhvD4/SE7L/3GKo1w/b+CPGnMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTGTI6DnMNiKttxPazwl/IONU+QvKQUfG/F/Fju7YAaHodRtcUBhf9ijoSRwwSlYcLUTnD2Nk3W784c30ZWSteHCxazmUXF6Vgb59OMawYPEKJ4pHipu1+Qz8TtMFPFRpGmMbvNlSZ3JztckRZBqHj50GkbJipR1huF2JqnzN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgBHW550JWNq_Ow2AA--.1311S2;
	Fri, 24 Jul 2026 16:42:29 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ben-linux@fluff.org,
	ben.dooks@codethink.co.uk,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	daniel.lezcano@kernel.org,
	tglx@kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v13 0/5] Update designware pwm driver
Date: Fri, 24 Jul 2026 16:41:53 +0800
Message-Id: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBHW550JWNq_Ow2AA--.1311S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tF43JFy5Zw15tFWrtrWUArb_yoW8GF1rJo
	WxCrW8Zw1UKry5Gwn2kr47CFW3W39Fqr1fX3yUWrZrAFyDJFn3Jw1Fgw45Xasxta4Uta98
	Zr43urZ7u3W3J3Wxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRK1vVDUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

There is already a patch [1] for the DesignWare PWM driver,
which is posted by Ben and still under review.
Based on this patch, this series is a continuation of [1]
to add support for IP versions 2.11a and later, which
includes support for "Pulse Width Modulation with 0%
and 100% Duty Cycle".

Supported chips:
ESWIN EIC7700 series SoC.

Test:
Tested this patch on the Sifive HiFive Premier P550 (which uses the EIC7700
SoC).

[1] https://lore.kernel.org/lkml/20230907161242.67190-1-ben.dooks@codethink.co.uk/

Updates:
  Changes in v13:
  - YAML:
    - Dropped Conor's Acked-by due to significant schema changes for
      patch 1 and 2.
    - Add 'Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>'
      for patch 4.
    - Add a reset-names property in snps,dw-apb-timers-pwm2.yaml.
    - Add description "Combined APB interface and timer logic reset"
      for the eswin,eic7700-pwm resets property, because the single
      entry is the combined interface bus and timer logic reset.
    - Mark reset-names as not applicable (reset-names: false) for
      this compatible, since there is only one reset.
  - Driver:
    - Remove the structure 'dwc_pwm_plat_data', because it is not needed
      to distinguish whether to support resets.
    - Drop reset_required and use
      devm_reset_control_array_get_optional_exclusive().
    - Replace dev_err() with dev_err_probe() in the probe function.
    - Add patch 5 for dw_apb_timer_of.c. Replace of_reset_control_get()
      with of_reset_control_array_get_optional_exclusive() to get both
      resets from the device tree (Sashiko review of v12).

  - Link to v12: https://lore.kernel.org/all/20260721120757.1134-1-dongxuyang@eswincomputing.com/

  Changes in v12:
  - YAML:
    - Update snps,dw-apb-timer binding to allow up to two reset lines
      (Sashiko review of v11).
  - Driver:
    - Update the boundary check to match hardware specification.
      Check the low and high boundary no more than 1 << 32
      (Sashiko review of v11).
    - Replace "dwc->feature" with "ctrl" in dwc_pwm_get_state().
      Check DWC_TIM_CTRL_0N100PWM_EN bit from the hardware control
      register to determine the actual timing formula in use
      (Sashiko review of v11).
    - Save the initial hardware state into dwc->ctx in probe() before
      clocks are gated (Sashiko review of v11).

  - Link to v11: https://lore.kernel.org/all/20260709081337.2022-1-dongxuyang@eswincomputing.com/

  Changes in v11:
  - YAML:
    - The timer binding does not need to be updated
      (Sashiko review of v10).
  - Driver:
    - Mask the interrupt by setting the DWC_TIM_CTRL_INT_MASK bit
      (Sashiko review of v10).
    - Call pm_runtime_disable() before manually rolling back the clock
      state (Sashiko review of v10).
      Drop pm_runtime_resume_and_get() and pm_runtime_put_sync(). Access
      registers and disable clocks only in the resumed state.
    - Remove reset assert in remove function, as disabling PM and clocks
      prevents further operation (Sashiko review of v10).

  - Link to v10: https://lore.kernel.org/all/20260703093308.482-1-dongxuyang@eswincomputing.com/

  Changes in v10:
  - Driver:
    - Do not add a dependency on PM. Additionally, the issues below will
      be fixed to ensure compatibility with and without PM support
      (Sashiko review of v9).
    - Note that writes to dwc->clk_rate in apply()/get_state() cannot race
      due to PWM core's chip->nonatomic_lock (Sashiko review of v9).
    - Fix __dwc_pwm_configure_timer() precision loss from dual rounding
      (compute period_cyc once); reject sub-clock-cycle periods in 0N100
      mode (add !period_cyc check to avoid writing 0 to LD_CNT/LD_CNT2).
    - dwc_pwm_get_state():
      Fix pm_runtime_resume_and_get() error check to use 'if (ret < 0)' to
      allow stub return value 1 when CONFIG_PM=n.
    - Deassert reset before reading MMIO in probe() to avoid bus stalls on
      SoCs that leave the block in reset (Sashiko review of v9).
    - Keep clocks enabled when CONFIG_PM=n.
      Condition the clock gating on IS_ENABLED(CONFIG_PM)
      (Sashiko review of v9).
    - Move register save/restore into runtime PM callbacks.
      Replace legacy suspend/resume with pm_runtime_force_suspend()/resume()
      to properly manage the generic power domain.

  - Link to v9: https://lore.kernel.org/all/20260701004139.347-1-dongxuyang@eswincomputing.com/

  Changes in v9:
  - YAML:
    - Add 'Acked-by: Conor Dooley <conor.dooley@microchip.com>' for
      patch 1 and 2.
  - Driver:
    - __dwc_pwm_configure_timer():
      reads state->polarity and swaps registers:
      NORMAL (active-high): duty_cycle to DWC_TIM_LD_CNT2 (HIGH),
      remainder to DWC_TIM_LD_CNT (LOW)
      INVERSED (active-low): duty_cycle to DWC_TIM_LD_CNT (LOW),
      remainder to DWC_TIM_LD_CNT2 (HIGH)
      Applies to both 0N100 and classic paths.
      dwc_pwm_apply():
      removed -EINVAL polarity guard; both polarities accepted.
      dwc_pwm_get_state():
      reconstructs polarity from pwm->state.polarity (last apply() value);
      initial read zero-initialized to PWM_POLARITY_NORMAL; decode mirrors
      apply() swap logic for consistent round-trip (Sashiko review of v8).
    - Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
      dwc_pwm_apply() and add error checking (Sashiko review of v8).
    - Add a non-zero check for clk_rate in dwc_pwm_get_state().
      Add a non-zero check for dwc->clk_rate in probe (Sashiko review of v8).
    - When pwm_en is true, adding 'goto disable_clk;'. When pwm_en is false,
      return early from pm_disable without falling through to disable_clk.
      (Sashiko review of v8).
    - Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
      dwc_pwm_plat_remove() and add error checking.
      On failure, skip register reads and pm_runtime_put_sync()
      (Sashiko review of v8).
    - Remove the -EBUSY check in dwc_pwm_suspend() and save all contexts
      (Sashiko review of v8).
    - Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
      dwc_pwm_resume() (Sashiko review of v8).

  - Link to v8: https://lore.kernel.org/all/20260623071329.2034-1-dongxuyang@eswincomputing.com/

  Changes in v8:
  - YAML:
    - Split the v7 binding into two patches.
      Patch 1 explains why to add the resets property.
      Patch 2 adds the eswin compatible string and specified reset.
  - Driver:
    - Use mul_u64_u64_div_u64() to safely scale the values and avoid
      64-bit multiplication overflow in __dwc_pwm_configure_timer()
      and dwc_pwm_get_state().
      Add the include for linux/math64.h (Sashiko review of v7).
    - Keep the current usage of pwm->args.polarity until a better solution
      is available.
    - Use pm_runtime_resume_and_get() in dwc_pwm_get_state() instead of
      pm_runtime_get_sync(), so that register access is skipped if the
      device fails to resume (Sashiko review of v7).
    - Replace devm_pwmchip_add() with pwmchip_add() and move it after
      pm_runtime_enable(), so that the PWM chip is registered only after
      runtime PM has been fully initialized (Sashiko review of v7).
    - Remove the reset_assert label and reset_control_assert()
      (Sashiko review of v7).
    - Remove the pm_runtime_status_suspended() check and unconditionally
      use pm_runtime_get_sync() instead (Sashiko review of v7).
    - Remove  the pwm_en flag, but keep the pm_runtime_put_noidle() call
      (Sashiko review of v7; see email for explanation)
    - Use pm_runtime_status_suspended() to check the runtime PM status.
      If the device is not suspended (i.e., active), call
      clk_disable_unprepare(). If it is suspended, skip this block
      (Sashiko review of v7).
    - Use an explicit pwmchip_remove() as the first step of .remove(),
      instead of relying on devm_pwmchip_add() to unregister the chip
      after .remove() returns. This prevents the hardware teardown that
      follows from racing against a still-registered chip
      (Sashiko review of v7).
    - Add a check for dwc->rst before asserting reset in the remove path
      (Sashiko review of v7).
    - Drop the return value check from pm_runtime_put_sync()
      (Sashiko review of v7).

  - Link to v7: https://lore.kernel.org/all/20260605082242.1541-1-dongxuyang@eswincomputing.com/

  Changes in v7:
  - YAML:
    - Dropped Conor's Acked-by due to significant schema changes.
    - Rename patch 1 from "dt-bindings: pwm: dwc: add optional reset" to
      "dt-bindings: pwm: dwc: Add eswin compatible and resets property".
    - Update the commit message to explain why the EIC7700 supports only
      one reset.
    - Add constraints 'minItems: 1' and 'maxItems: 1' for the 'resets'
      property of eswin,eic7700-pwm.
    - Add an example for eswin,eic7700-pwm.

  - Link to v6: https://lore.kernel.org/all/20260424094529.1691-1-dongxuyang@eswincomputing.com/

  Changes in v6:
  - YAML:
    - Drop properties resets and its items description for eswin,eic7700-pwm.

  - Link to v5: https://lore.kernel.org/all/20260423083644.1168-1-dongxuyang@eswincomputing.com/

  Changes in v5:
  - YAML:
    - Add 'eswin,eic7700-pwm' compatible string.
    - Add the items description for the resets property and set minItems to 1.
    - Require resets property with exactly 1 reset for eswin,eic7700-pwm compatible.
  - Driver:
    - Add support for 'eswin,eic7700-pwm' compatible.
    - Add structure dwc_pwm_plat_data to manage the API for obtaining resets.

  - Link to v4: https://lore.kernel.org/all/20260415094908.1539-1-dongxuyang@eswincomputing.com/

  Changes in v4:
  - YAML:
    - Change maxItems from 1 to 2. As there is a corresponding reset signal
      for each clock domain, the effective maxItems of the resets property
      is set to 2.
    - Update the YAML commit message to describe the hardware.
  - Driver:
    - Replace devm_reset_control_get_optional_exclusive() with
      devm_reset_control_array_get_optional_exclusive(). Since the number
      of reset signals has increased from one to two, we need to use the
      array API to acquire them.

  - Link to v3: https://lore.kernel.org/all/20260402091718.1608-1-dongxuyang@eswincomputing.com/

  Changes in v3:
  - YAML:
    - Added a clear justification for the optional resets property. It is
      required to support proper controller initialization when no PWM
      channel is active at boot time, while allowing the driver to skip
      reset deassertion if any channel is already enabled.
  - Driver:
    - Update the boundary value check of tmp in __dwc_pwm_configure_timer()
      for DWC_TIM_CTRL_0N100PWM_EN.
    - Replace 'sizeof(struct dwc_pwm_drvdata)' with
      'struct_size(data, chips, 1)'.
    - Drop devm_clk_get_enabled() in favor of devm_clk_get() with explicit
      clk_prepare_enable() and clk_disable_unprepare() allowing runtime PM
      to manage clock state.
    - Replace devm_reset_control_get_optional_exclusive_deasserted() with
      devm_reset_control_get_optional_exclusive() and issue a full reset via
      reset_control_reset() only when no PWM channel is active at probe time.
    - Detect bootloader-enabled PWM channels by reading the enable bit, and
      initialize runtime PM as active for those channels by calling
      pm_runtime_set_active() and pm_runtime_get_noresume().
    - Remove autosuspend as it is not required for this driver.
    - Use explicit pm_runtime_enable() and pm_runtime_disable() instead of
      the managed devm_pm_runtime_enable() variant to ensure correct cleanup.
    - On device removal, recheck the channel enable status. If any channel
      remains active, call pm_runtime_put_noidle() before disabling clocks
      via clk_disable_unprepare().
      Resume device before register access during removal if it is runtime
      suspended, and re-suspend it afterward.
    - If device is suspended, resume it before register access during system
      resume/suspend.
    - Use pm_ptr() instead of pm_sleep_ptr() for correct PM operation.

  - Link to v2: https://lore.kernel.org/all/20260306093000.2065-1-dongxuyang@eswincomputing.com/

  Changes in v2:
  - YAML:
    - Remove eswin,eic7700-pwm.yaml. Use snps,dw-apb-timers-pwm2.yaml.
      The description in snps,dw-apb-timers-pwm2.yaml is better.
    - Add the resets property as optional, as defined in the databook.
    - Remove snps,pwm-full-range-enable as no additional property is needed.
  - Driver:
    - Change the file from pwm-dwc-eic7700.c to pwm-dwc-of.c from [1].
    - Define DWC_TIM_VERSION_ID_2_11A 2.11a as the baseline version.
    - Enable the 0% and 100% duty cycle mode by setting dwc->feature if
      the version read from the TIMERS_COMP_VERSION register is later
      than or equal to DWC_TIM_VERSION_ID_2_11A.
    - Use the DIV_ROUND_UP_ULL() to calculate width in the .apply and
      .get_state.
    - Additionally, Power Management (PM) support has been added to the
      pwm-dwc-of.c driver.
    - Drop the headers that are not used.
    - Use devm_clk_get_enabled() instead of devm_clk_get().
    - Drop of_match_ptr.
    - Fix build error with 1ULL << 32.
      Reported-by: kernel test robot <lkp@intel.com>
      Closes: https://lore.kernel.org/oe-kbuild-all/202512061720.j31AsgM7-lkp@intel.com/

  - Link to v1: https://lore.kernel.org/all/20251205090411.1388-1-dongxuyang@eswincomputing.com/
  - Link to v9: https://lore.kernel.org/lkml/20230907161242.67190-1-ben.dooks@codethink.co.uk/

Xuyang Dong (5):
  dt-bindings: pwm: dwc: Document optional resets property
  dt-bindings: pwm: dwc: Add eswin compatible
  pwm: dwc: add of/platform support
  dt-bindings: timer: dwc: Update resets property items
  clocksource: dw_apb_timer: Use reset array API to handle all resets

 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml |  45 ++-
 .../bindings/timer/snps,dw-apb-timer.yaml     |   5 +-
 drivers/clocksource/dw_apb_timer_of.c         |   6 +-
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-dwc-core.c                    | 172 ++++++++--
 drivers/pwm/pwm-dwc-of.c                      | 299 ++++++++++++++++++
 drivers/pwm/pwm-dwc.h                         |  25 +-
 8 files changed, 517 insertions(+), 46 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

--
2.34.1

