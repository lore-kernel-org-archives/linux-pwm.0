From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/5] pwm: add the Berlin pwm controller driver
Date: Mon, 27 Jul 2015 08:10:22 +0200
Message-ID: <20150727061022.GN8283@kwain>
References: <1437860378-9556-1-git-send-email-antoine.tenart@free-electrons.com>
 <1437860378-9556-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAAEAJfA9ZH7xcKLY-qVvEbOeozxg_Vb9MjgoMBk3ceZCr00ciw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39510 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750842AbbG0GKY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2015 02:10:24 -0400
Content-Disposition: inline
In-Reply-To: <CAAEAJfA9ZH7xcKLY-qVvEbOeozxg_Vb9MjgoMBk3ceZCr00ciw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, jszhang@marvell.com, thierry.reding@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Hi,

On Sun, Jul 26, 2015 at 07:56:55PM -0300, Ezequiel Garcia wrote:
> El jul. 25, 2015 6:40 PM, "Antoine Tenart" <antoine.tenart@free-elect=
rons.com>
> escribi=F3:
> > +
> > +static const struct of_device_id berlin_pwm_match[] =3D {
> > +=A0 =A0 =A0 =A0{ .compatible =3D "marvell,berlin-pwm" },
>=20
> Don't we need a sentinel here?

Oops. I'll fix that.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
