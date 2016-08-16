From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 00/17] pwm: Add support for PWM Capture
Date: Tue, 16 Aug 2016 10:34:51 +0100
Message-ID: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38083 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbcHPJfj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2016 05:35:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id o80so154606741wme.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2016 02:35:39 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

This patch-set makes use of the new Capture API by supplying PWM
Capture functionality into the already existing STi PWM driver.

v3 => v4:
- Keep DTB backward compatibilty

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

Lee Jones (17):
  ARM: dts: STiH407: Supply PWM Capture IRQ
  ARM: dts: STiH407: Declare PWM Capture data lines via Pinctrl
  ARM: dts: STiH416: Supply PWM Capture IRQs
  ARM: dts: STiH416: Declare PWM Capture data lines via Pinctrl
  ARM: dts: STiH416: Define PWM Capture clock
  ARM: dts: STiH416: Define the number of PWM Capture channels
  pwm: sti: Rename channel => device
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

 Documentation/devicetree/bindings/pwm/pwm-st.txt |   8 +-
 arch/arm/boot/dts/stih407-family.dtsi            |   1 +
 arch/arm/boot/dts/stih407-pinctrl.dtsi           |   3 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi           |   5 +
 arch/arm/boot/dts/stih416.dtsi                   |   8 +-
 drivers/pwm/pwm-sti.c                            | 424 +++++++++++++++++++----
 6 files changed, 373 insertions(+), 76 deletions(-)

-- 
2.9.0
