From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Mon, 25 Mar 2019 09:50:37 +0100
Message-ID: <20190325085037.f4weycbhaa7yyurt@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: thierry.reding@gmail.com, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Mar 25, 2019 at 09:41:53AM +0100, Uwe Kleine-König wrote:
> If you want to implement further cleanups, my questions and propositions
> are:
> 
>  - Is there a publicly available manual for this hardware? If yes, you
>    can add a link to it in the header of the driver.
> 
>  - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
>    this be more suitable in .apply?
> 
>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>    register) freeze the output, or is the currently running period
>    completed first? (The latter is the right behaviour.)
> 
>  - Please point out in the header that for changing period/duty
>    cycle/polarity the hardware must be stopped. (I suggest to apply the
>    style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
>    for some consistency.)

Another thing I just noted: The .get_state callback only sets .enabled
but nothing of the remaining information is provided.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
