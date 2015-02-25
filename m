From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
Date: Wed, 25 Feb 2015 09:42:54 +0100
Message-ID: <20150225084254.GI7789@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de>
 <20150224190636.GG7789@pengutronix.de>
 <54ED8426.6090401@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54ED8426.6090401@i2se.com>
Sender: linux-leds-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Bryan Wu <cooloney@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Stefan,

On Wed, Feb 25, 2015 at 09:13:26AM +0100, Stefan Wahren wrote:
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Thanks.

> >> This is the functional part of this issue, since the warning has b=
een fixed [1]
> > Can I interpret this as an Tested-by: for this patch and an Ack for
> > patch 1?
>=20
> Sorry, but i don't think i'm the right person for acking patch 1.
IMHO it doesn't matter who you are for an ack. You can consider it righ=
t
and tell it. How much this ack is useful to convince a maintainer to
take this patch is a different story.

But given that I try to fix the problem at hand for >2 years and I'm
stuck because Thierry isn't convinced that it's a correct way to go
forward but also doesn't come up with an alternative I'm happy about
everyone who gives his/her opinion. Still more if the opinion matches
mine.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
