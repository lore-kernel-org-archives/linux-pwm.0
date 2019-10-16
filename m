Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfJPIdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 04:33:04 -0400
Date: Wed, 16 Oct 2019 10:33:01 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191016083301.63okdbunkq2slevu@pengutronix.de>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016073842.1300297-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 0/3] pwm: stm32: Minor cleanups
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 09:38:39AM +0200, Thierry Reding wrote:
> Hi,
>=20
> Looking at Fabrice's STM32 patches I noticed that we're now passing the
> breakinput values (u32) into a function via int parameters. The easiest
> way to fix this inconsistency is by just passing a pointer to the break
> input structure. There's some preparatory work here that makes the code
> slightly more readable, in my opinion, but it's really marginal, so I'm
> not terribly thrilled by this series in retrospect.
>=20
> If nobody else thinks this is a big improvement I'll just scrap it.

I like it. Together with my suggestion to add parameters to the register
offsets I think it's worth the effort.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
