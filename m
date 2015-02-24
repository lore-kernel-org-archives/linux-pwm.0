From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
Date: Tue, 24 Feb 2015 20:06:36 +0100
Message-ID: <20150224190636.GG7789@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
Sender: linux-leds-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Bryan Wu <cooloney@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Stefan,

On Tue, Feb 24, 2015 at 07:56:52PM +0100, Stefan Wahren wrote:
> After replacing "i" with "priv->num_leds" in this patch we are able t=
o use pwm
> led with trigger heartbeat.
Right, that's what I did in my tree to to please the build robot :-)

> This is the functional part of this issue, since the warning has been=
 fixed [1]
Can I interpret this as an Tested-by: for this patch and an Ack for
patch 1?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
