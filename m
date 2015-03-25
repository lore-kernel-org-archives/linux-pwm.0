From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
Date: Wed, 25 Mar 2015 11:14:28 +0100
Message-ID: <20150325101428.GB32677@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58174 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbbCYKOd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Mar 2015 06:14:33 -0400
Content-Disposition: inline
In-Reply-To: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>

[Cc: +=3D akpm]

On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K=F6nig wrote:
> on arm/i.MX28 the leds connected to a pwm are still broken and it's m=
ore
> than three years ago that I came up with these patches. I still consi=
der
> them to do the right thing and they fix a real bug.
I'm really frustrated here. I want to fix a real bug, made several
suggestions (with patches) how to fix it and still have to include my
local patches in each project that uses leds on i.MX28's pwm output.

Thierry, how can we get this resolved?

Best regards
Uwe

> Old threads to this topic include:
>=20
> 	http://thread.gmane.org/gmane.linux.kernel/1381289
> 	http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D=
282596
> 	http://thread.gmane.org/gmane.linux.pwm/1749
>=20
> Uwe Kleine-K=F6nig (2):
>   pwm/doc: Clearify that the pin state after pwm_disable is undefined
>   leds/pwm: Don't disable pwm when setting brightness to 0
>=20
>  Documentation/pwm.txt   |  5 +++++
>  drivers/leds/leds-pwm.c | 10 +++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
