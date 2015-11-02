From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: Sysfs: no udev notification on export
Date: Mon, 2 Nov 2015 13:31:11 +0100
Message-ID: <CAPoCmYKObYAu456sos2a4gpB4QH7sSo9wo8=FQZGkhRUgyu6zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33270 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbKBMbb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Nov 2015 07:31:31 -0500
Received: by obbwb3 with SMTP id wb3so93543891obb.0
        for <linux-pwm@vger.kernel.org>; Mon, 02 Nov 2015 04:31:30 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hsweeten@visionengravers.com
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com

I noticed that pwm/sysfs.c doesn't seem to notify user space after a
channel has been exported through the sysfs interface. This does e.g.
happen with gpio/gpiolib-sysfs.c, and allows udev to jump in and
change permissions of newly exported PWM channels. (This seems racy,
but I believe this is the best way to do it right now..)

Before I start familiarizing myself with the linux driver model: would
you be open to changing the current behavior?

(I believe device_create_with_groups() vs device_create() &
device_register() is what's causing this, but I don't yet know the
implications of using one over the other.)

Thanks
Gottfried
