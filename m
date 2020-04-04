From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v1] pwm: pca9685: re-enable active pwm channels on pwm
 period change
Date: Sat, 4 Apr 2020 15:21:19 -0400
Message-ID: <CAGngYiX75gxrK+rKQcTVG6byAB+o5enC++J_0tHe6-6pRPMczQ@mail.gmail.com>
References: <20200403235324.27437-1-TheSven73@gmail.com> <20200404175836.GB55833@workstation.tuxnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35165 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgDDTVb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Apr 2020 15:21:31 -0400
In-Reply-To: <20200404175836.GB55833@workstation.tuxnet>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Apr 4, 2020 at 1:58 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> According to the PCA9685 datasheet revision 4, page 15, the RESTART bit
> is not only cleared by writing a 1 to it, but also by other actions like
> a write to any of the PWM registers.
>
> This seems to be the reason why I could not reproduce the reported
> problem.

Thanks Clemens for checking this. If .config will always write at least one
of the pwm registers (which seems to be the case), then all pwm channels
should stay on after a period change. And we (fortunately) won't need this
patch.
