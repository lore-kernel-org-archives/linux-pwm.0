From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
Date: Wed, 25 Feb 2015 09:13:26 +0100
Message-ID: <54ED8426.6090401@i2se.com>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de> <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de> <1151818200.134325.1424804213026.JavaMail.open-xchange@oxbsltgw03.schlund.de> <20150224190636.GG7789@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150224190636.GG7789@pengutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Bryan Wu <cooloney@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

Am 24.02.2015 um 20:06 schrieb Uwe Kleine-K=F6nig:
> Hello Stefan,
>
> On Tue, Feb 24, 2015 at 07:56:52PM +0100, Stefan Wahren wrote:
>> After replacing "i" with "priv->num_leds" in this patch we are able =
to use pwm
>> led with trigger heartbeat.
> Right, that's what I did in my tree to to please the build robot :-)

in that case, here is my:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

>> This is the functional part of this issue, since the warning has bee=
n fixed [1]
> Can I interpret this as an Tested-by: for this patch and an Ack for
> patch 1?

Sorry, but i don't think i'm the right person for acking patch 1.

Stefan

> Best regards
> Uwe
>
