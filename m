Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405991AbfHIJKu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 05:10:50 -0400
Date: Fri, 9 Aug 2019 11:10:47 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190809091047.2hrlt245ssjoztfn@pengutronix.de>
References: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Thu, Aug 08, 2019 at 12:55:40PM +0300, Sergei Shtylyov wrote:
> Hello!
>=20
> On 08.08.2019 9:38, Yoshihiro Shimoda wrote:
>=20
> > Since the rcar_pwm_apply() has already check whehter state->enabled
>=20
>    Checked?

and "whether"

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
