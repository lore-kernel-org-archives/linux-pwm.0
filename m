From: Pedro Aguilar <p.aguilar@nethix.com>
Subject: LCD with PWM backlight doesn't seem to work with atmel-hlcdc driver
Date: Mon, 11 Jan 2016 19:38:18 +0100
Message-ID: <5693F69A.8010204@nethix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpout06.impresasemplice.it ([83.221.127.55]:44268 "EHLO
	smtpout06.impresasemplice.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933275AbcAKSnv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2016 13:43:51 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: boris.brezillon@free-electrons.com

Hi,

I'm working on a custom board based on the Atmel sama5d3_ek. I have an 
LCD (T430T01W01A from Cristal Clear Technology) that has a PWM backlight 
and it should be supported in the device tree files (sama5d34ek_pda4) 
and the panel_simple driver since it's compatible with the already 
supported Innolux at043tn24.

When booting I see in the LCD the Atmel logo with some info, this means 
that electrically the board and the LCD work fine.

I built the LCD modules (pwm_atmel_hlcdc, backlight, pwm_bl, 
panel_simple and atmel_hlcdc_dc) out of the kernel and modprobe'd them 
manually after booting:

# modprobe pwm_atmel_hlcdc
# modprobe backlight
# modprobe pwm_bl
backlight_device_register: name=backlight
# modprobe panel_simple
# modprobe atmel_hlcdc_dc
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
atmel-hlcdc-display-controller atmel-hlcdc-dc: DRM device successfully 
registered
atmel-hlcdc-display-controller atmel-hlcdc-dc: fb0: frame buffer device
atmel-hlcdc-display-controller atmel-hlcdc-dc: registered panic notifier
#

When modprobing pwm_bl the LCD seemed to be turned-off (the logo from 
uboot goes away) and the the PWM backlight is off.

I tried several user space programs (fb-set-rect and Qt5 examples built 
with buildroot) but the LCD seemed dead. All the entries in sysfs, such 
as /sys/class/backlight were present, but didn't work. For example, I 
tried to power on/off the backlight

echo 1 > /sys/class/backlight/backlight/bl_power
echo 0 > /sys/class/backlight/backlight/bl_power

but it didn't work. The same with the brightness.

The datasheet of this LCD and the Innolux LCD are equivalent.

It seems that there is something related to the voltage in the PWM 
backlight or panel regulators?

Do you have any idea/hint of what could cause this issue?

Thanks!

--
Pedro Aguilar
