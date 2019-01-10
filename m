Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57069 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfAJKSW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jan 2019 05:18:22 -0500
Date: Thu, 10 Jan 2019 11:18:18 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190110101818.msnvtpw6yczpeybc@pengutronix.de>
References: <20190109082747.GA5476@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190109082747.GA5476@kadam>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: imx: Signedness bug in imx_pwm_get_state()
To: Dan Carpenter <dan.carpenter@oracle.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Anson Huang <anson.huang@nxp.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Jan 09, 2019 at 11:27:47AM +0300, Dan Carpenter wrote:
> "ret" only holds zero and negative error codes.  It needs to be signed
> for the error handling to work.
>=20
> Fixes: 9f4c8f9607c3 ("pwm: imx: Add ipg clock operation")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I would have expected a compiler warning but at least for me there is
none emitted. Hmm.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

@Thierry: Given that this is a fix I assume you want to apply this patch
before my pwm-imx series (which is cleanup only). This will conflict for
sure with my driver splitting patch. Please tell me if/when I should
resend my series rebased on top of this patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
