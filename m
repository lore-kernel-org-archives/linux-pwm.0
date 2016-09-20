From: John Tobias <john.tobias.ph@gmail.com>
Subject: PWM on Suspend To Ram
Date: Tue, 20 Sep 2016 08:50:29 -0700
Message-ID: <CACUGKYNYLnRkWuaMWsc+524C2TscjL2L2AU-eFP-JNKy879AvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:33476 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbcITPub (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2016 11:50:31 -0400
Received: by mail-it0-f44.google.com with SMTP id x192so26441002itb.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Sep 2016 08:50:31 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

Hi Guys,

I have an iMX6 board and I can put the device in Suspend to RAM mode.
While in the said mode, I would like to keep the PWM up and running
(The iMX6 PWM support low power mode).

During the suspend mode, I set all the registers that I do believe to
enable the PWM, but I am not getting the any signals.

I would like to know if anyone here have any idea how to tweak it in
order to accomplish for what I need?.

Regards,

John
