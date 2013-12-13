From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv7 0/4] Add Freescale FTM PWM driver.
Date: Fri, 13 Dec 2013 16:57:03 +0800
Message-ID: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:43544 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495Ab3LMJsH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Dec 2013 04:48:07 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: mark.rutland@arm.com, s.hauer@pengutronix.de, galak@codeaurora.org, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, matt.porter@linaro.org, linux@arm.linux.org.uk, rob@landley.net, tomasz.figa@gmail.com, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

This patch series is the Freescale FTM PWM implementation. And there
are 8 channels most supported by the FTM PWM. This implementation is
only compatible with device tree definition.

This patch series is based on linux-next and has been tested on Vybrid
VF610 Tower board using device tree.


Changes in v7:
- Add big-endian mode support.
- Add FTM mutex lock.
- Add period time check with the current running pwm(s).
- Recode the counter clock source selecting.
- Sort some header files alphabetically, etc.

Changes in v6:
- Remove "fsl,pwm-counter-clk".

Changes in v5:
- Remove active/idle pinctrl stuff.

Changes in v4:
- Check for the result and return an error for devm_kzalloc().
- Move pinmux setting from the SoC file to the board specific file.
- Revise the written mistake of 'ret |= FTMSC_CLKEXT;' --> 'reg |= FTMSC_CLKEXT;'.


Changes in v3:
- Remove "availabe" field.
- Remove "fsl,pwm-avaliable-chs" property.
- ...

Changes in v2:
- Remove PWM CPWM/EPWM feature and sysfs.
- Remove some redundant code.
- Revise some code for more readable.
- Remove "fsl,pwm-clk-ps", "fsl,pwm-number", "fsl,pwm-channels",etc.
- Add "fsl,pwm-avaliable-chs", "fsl,pwm-counter-clk", etc.
- Support 8 channels default in dtsi file.
- Add counter clock source selection.
- Rename some function name, macro name, etc.
- Use PWM's and OF's existing function interfaces.
- Split clk_unprepare_enable to clk_unprepare and clk_enable,etc.
- ...

Added in v1:
- Add Freescale FTM PWM driver support.
- Add Freescale FTM PWM node for VF610.
- Enable Enables FTM PWM device for Vybrid VF610 TOWER.
- Add device tree bindings for Freescale.








