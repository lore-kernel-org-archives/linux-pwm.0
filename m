Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43905 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJULLP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 07:11:15 -0400
Date: Mon, 21 Oct 2019 13:11:12 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191021111112.n24kme2va6net7g3@pengutronix.de>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/4] pwm: Read initial hardware state at request time
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Oct 21, 2019 at 12:57:36PM +0200, Thierry Reding wrote:
> The PWM core doesn't need to know about the hardware state of a PWM
> unless there is a user for it. Defer initial hardware readout until
> a PWM is requested.

A side effect is that for an unused PWM the get_state callback is never
called (which is good), in return it is called more than once if the PWM
is requested more often (which is bearable).

> As a side-effect, this allows the ->get_state() callback to rely on
> per-PWM data.

Given that this is the motivation for your change I'd give more stress
to this part of the commit log. Also I think this could be more
understandable if you point out that the effect is that .get_state is
only called after .request was called successfully which gives the low
level driver more freedom by (for example) relying on memory allocated
there.

I assume you target the next merge window for this change?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
