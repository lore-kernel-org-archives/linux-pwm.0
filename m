From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 00/20] pwm: Add support for PWM Capture
Date: Wed,  8 Jun 2016 10:21:15 +0100
Message-ID: <20160608092135.21184-1-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35025 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161804AbcFHJV1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jun 2016 05:21:27 -0400
Received: by mail-wm0-f44.google.com with SMTP id v199so54370713wmv.0
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jun 2016 02:21:26 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

The first part of this set extends the current PWM API to allow external
code to request a PWM Capture.  Subsequent patches then make use of the
new API by providing a userspace offering via /sysfs.  The final part of
the set supplies PWM Capture functionality into the already existing STi
PWM driver.

This patch-set has been tested end to end via /sysfs.

v2 => v3:
- Supply DT documentation changes
- Submit DTS additions as part of this set
- Default Capture and PWM-out number of channels to 0
  - Do additional checking, to ensure at least one channel is requested
- Use global locking, instead of lock in device data

v1 => v2:
- API change
- Use a struct to carry the result back to the caller
- Use 'struct pwm' to store device specific data
- Make timeout configurable
- Don't use clear_bit(), instead use raw bit logic
- Propagate return value of platform_get_irq()
- Don't cast to (void *)
- Move to subsystem terminology (channels => devices)
- Remove channel select feature
- Enable Capture IP during capture

Lee Jones (20):
  ARM: dts: STi: Rename properites in line with PWM naming conventions
  ARM: dts: STiH407: Supply PWM Capture IRQ
  ARM: dts: STiH407: Declare PWM Capture data lines via Pinctrl
  ARM: dts: STiH416: Supply PWM Capture IRQs
  ARM: dts: STiH416: Declare PWM Capture data lines via Pinctrl
  ARM: dts: STiH416: Define PWM Capture clock
  ARM: dts: STiH416: Define the number of PWM Capture channels
  pwm: Add PWM Capture support
  pwm: sti: Rename channel => device
  pwm: sysfs: Add PWM Capture support
  pwm: sti: Reorganise register names in preparation for new
    functionality
  pwm: sti: Only request clock rate when you need to
  pwm: sti: Supply PWM Capture register addresses and bit locations
  pwm: sti: Supply PWM Capture clock handling
  pwm: sti: Initialise PWM Capture device data
  pwm: sti: Add support for PWM Capture IRQs
  pwm: sti: Add PWM Capture call-back
  pwm: sti: It's now valid for number of PWM channels to be zero
  pwm: sti: Take the opportunity to conduct a little house keeping
  dt-bindings: pwm: sti: Update DT bindings with recent changes

 Documentation/devicetree/bindings/pwm/pwm-st.txt |  10 +-
 arch/arm/boot/dts/stih407-family.dtsi            |   5 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi           |   3 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi           |   5 +
 arch/arm/boot/dts/stih416.dtsi                   |  12 +-
 drivers/pwm/core.c                               |  27 ++
 drivers/pwm/pwm-sti.c                            | 424 +++++++++++++++++++----
 drivers/pwm/sysfs.c                              |  17 +
 include/linux/pwm.h                              |  25 ++
 9 files changed, 447 insertions(+), 81 deletions(-)

-- 
2.8.3
