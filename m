Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:38533
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfHSGQe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 19 Aug 2019 02:16:34 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 Aug 2019 06:16:29 +0000
Message-ID: <TYAPR01MB45440E2AE2618955F27E9632D8A80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
 <20190809091047.2hrlt245ssjoztfn@pengutronix.de>
In-Reply-To: <20190809091047.2hrlt245ssjoztfn@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello!

Thank you for your review! And, I'm sorry for the delayed response because =
I had a vacation.

> From: Uwe Kleine-Konig, Sent: Friday, August 9, 2019 6:11 PM
>=20
> On Thu, Aug 08, 2019 at 12:55:40PM +0300, Sergei Shtylyov wrote:
> > Hello!
> >
> > On 08.08.2019 9:38, Yoshihiro Shimoda wrote:
> >
> > > Since the rcar_pwm_apply() has already check whehter state->enabled
> >
> >    Checked?
>=20
> and "whether"

I'll revise it.

Best regards,
Yoshihiro Shimoda

> Best regards
> Uwe
>=20
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
