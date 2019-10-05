Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:47003 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEV0s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Oct 2019 17:26:48 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so20795185ioo.13
        for <linux-pwm@vger.kernel.org>; Sat, 05 Oct 2019 14:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANBLGcyvpxWDxjpBrKDTySgUXGYFdn66O6_2jv-W5+RYd=n3pg@mail.gmail.com>
 <d959e6d0-c727-5c1d-b554-9306eba7f9ca@kleine-koenig.org>
In-Reply-To: <d959e6d0-c727-5c1d-b554-9306eba7f9ca@kleine-koenig.org>
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Sat, 5 Oct 2019 23:26:35 +0200
Message-ID: <CANBLGcx9jf+QDzrwgRdpn3L9__zPgEuCE=i3Qx1PEvs5JuEDgA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: pwm: Let pwm_get_state() return the last implemented state (01ccf903edd65f6421612321648fa5a7f4b7cb10)
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: linux-pwm@vger.kernel.org

Hi Uwe,

On Sat, 5 Oct 2019 at 21:53, Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
> On 10/5/19 9:37 PM, Emil Renner Berthing wrote:
> > My Chromebook Plus (rk3399-gru-kevin) doesn't display anything when
> > running 5.4-rc1 unless I revert this patch. It controls the backlight
> > through the cros-ec-pwm, so I'm guessing cros_ec_pwm_get_state doesn't
> > behave in way compatible with the backlight :/
>
> Can you interact with the machine even without backlight? If so adding
> some printk to the cros-ec-pwm driver would be great.
>
> I suggest to print period, duty_cycle and enabled at the start of
> cros_ec_pwm_apply() and at the end of cros_ec_pwm_get_state().
>
> If you'd then report your results with and without
> 01ccf903edd65f6421612321648fa5a7f4b7cb10 reverted to the pwm-list
> (linux-pwm@vger.kernel.org) in Cc: that would be great.

Sure. It seems cros_ec_pwm_get_state sets duty_cycle = 0. Here are the
relevant differences between a kernel with and without the revert:
http://ix.io/1XIU/diff

If you want to reproduce the debug patch is here:
http://ix.io/1XIW/diff

/Emil
