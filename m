From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Subject: Re: [PATCH] pwm: imx: don't reprogram PWMSAR if PWM is disabled
Date: Tue, 5 Aug 2014 04:47:00 +0400
Message-ID: <CALT56yOAjj12TnXMe5BTUtXysJArOdVXYXDPRzz_Q+A5RQJyNA@mail.gmail.com>
References: <1406102987-14797-1-git-send-email-dbaryshkov@gmail.com>
	<CALT56yON=icaJZa22F30caYOGVLiHqBdXX2sfHqTBArd+PxrFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38869 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbaHEArB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Aug 2014 20:47:01 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so243573iec.22
        for <linux-pwm@vger.kernel.org>; Mon, 04 Aug 2014 17:47:00 -0700 (PDT)
In-Reply-To: <CALT56yON=icaJZa22F30caYOGVLiHqBdXX2sfHqTBArd+PxrFA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pwm@vger.kernel.org

On Fri, Aug 1, 2014 at 10:02 PM, Dmitry Eremin-Solenikov
<dmitry_eremin@mentor.com> wrote:
> On Wed, Jul 23, 2014 at 12:09 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
>>
>> Writing several values to PWMSAR register with PWM being disabled can
>> lead to FIFO (connected to PWMSAR) being overflown. Then after enabling
>> PWM, hardware will use stale values. Instead cache the duty cycles and
>> write them to the hardware only before enabling PWM.
>
> What about this patch?

For the reference: the issue with the FIFO can be easily demonstrated on i.MX6
with the help of pwm-backlight. Steps to reproduce:

1) Disable backlight: echo 1 > /sys/class/..../bl_power
2) Change config several times:
  echo 1 > /sys/class/.../brightness
  echo 2 > /sys/class/.../brightness
  echo 3 > /sys/class/.../brightness
  echo 4 > /sys/class/.../brightness
  echo 7 > /sys/class/.../brightness

3) Reenable backlight and pwm:
  echo 0 > /sys/class/.../bl_power

At this point you get PWMSAR = 0, because of FIFO overflow (can be
verified by reading PWM status register).

-- 
With best wishes
Dmitry
