From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 4 Dec 2017 10:29:10 -0200
Message-ID: <CAOMZO5BAPedmpN4Ovzh==VdSJB4kod8nMkqbs6MKxkjSR5uv8w@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40400 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdLDM3L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Dec 2017 07:29:11 -0500
Received: by mail-ot0-f194.google.com with SMTP id e74so14514805ote.7
        for <linux-pwm@vger.kernel.org>; Mon, 04 Dec 2017 04:29:11 -0800 (PST)
In-Reply-To: <1511220443-26629-1-git-send-email-festevam@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Thierry,

On Mon, Nov 20, 2017 at 9:27 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> On a imx6q-cubox-i board, which has an LED driven by PWM, when the system
> goes into suspend the PWM block is disabled by default, then the PWM pin
> goes to logic level zero and turn on the LED during suspend, which is not
> really the behaviour we want to see.
>
> By keeping the PWM enabled during suspend via STOPEN bit, the pwm-leds
> driver sets the brightness to zero in suspend and then the LED is
> turned off as expected.
>
> So always set the STOPEN to fix the PWM behaviour in suspend.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v2:
> - Remove the optional dt property and set the STOPEN bit unconditionally (Rob)

Any comments?

Thanks
