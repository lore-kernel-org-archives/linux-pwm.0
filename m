Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF68422535;
	Mon, 27 Jul 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163457; cv=none; b=c+wexhZHuPTl1fiS2juDd10q3PLtnVu3hDJMuICGig3Qugoac1x3j3w9HogU1mjG0GbWWm1oTA16fdIqz6gvGXQ1VxcFJd0Uc+5n6GNDS724im9eFLclG9FSws7khHJchS1NPoXgRTEvUD3rRfwiTyP1eYDIO6klWk8mU7ckpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163457; c=relaxed/simple;
	bh=8hGJ1B+UPyTExZ68UQ3ehgB1l97/eam7gk5uPxJ09sQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JImpIxMn2vg1+DePby11he56el7OUl2PB9V8u7z/6bOolwLC9MfL3ay6u8K7uKDQKL9hlxriisaBxOVXCNpU3Z2L9H7vaPu9yDEw8TzNO1KlF1Os3b56QXP7E3T6y4Bt9RO1noZV1FlcEqMoh86esaD6ml17MsQ9POUSurqkizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BA741202058;
	Mon, 27 Jul 2026 16:44:01 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1woMYj-001ZQY-2A;
	Mon, 27 Jul 2026 16:44:01 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1woMYj-00000000Jvu-2PF1;
	Mon, 27 Jul 2026 16:44:01 +0200
Message-ID: <331adad68e3913cae30d8b1c5764177affabf60f.camel@pengutronix.de>
Subject: Re: Re: [PATCH v13 5/5] clocksource: dw_apb_timer: Use reset array
 API to handle all resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Xuyang Dong <dongxuyang@eswincomputing.com>, 
	sashiko-reviews@lists.linux.dev
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, 	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	daniel.lezcano@kernel.org, tglx@kernel.org,
 ningyu@eswincomputing.com, 	linmin@eswincomputing.com,
 xuxiang@eswincomputing.com, 	wangguosheng@eswincomputing.com,
 pinkesh.vaghela@einfochips.com
Date: Mon, 27 Jul 2026 16:44:01 +0200
In-Reply-To: <63b2ba86.8bcf.19fa2e572f4.Coremail.dongxuyang@eswincomputing.com>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
	 <20260724084437.1850-1-dongxuyang@eswincomputing.com>
	 <20260724085527.D31BC1F000E9@smtp.kernel.org>
	 <63b2ba86.8bcf.19fa2e572f4.Coremail.dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mo, 2026-07-27 at 17:26 +0800, Xuyang Dong wrote:
> >=20
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] The patch dynamically allocates an exclusive reset control arr=
ay using the unmanaged `of_` API but fails to free it, permanently locking =
shared APB resets and deadlocking other devices.
> > --
> >=20
> > --- Patch [5]: [PATCH v13 5/5] clocksource: dw_apb_timer: Use reset arr=
ay API to handle all resets ---
> > commit 015418d722b66a454000fd7a9c2606bea3f7e18b
> > Author: Xuyang Dong <dongxuyang@eswincomputing.com>
> >=20
> > clocksource: dw_apb_timer: Use reset array API to handle all resets
> >=20
> > This patch updates the timer initialization to fetch and pulse all rese=
t lines
> > specified in the device tree by switching to the reset array API.
> >=20
> > > Replace it with devm_reset_control_array_get_optional_exclusive() to
> > > fetch and control all reset lines listed in the device tree, ensuring
> > > every line is properly asserted and deasserted rather than only the f=
irst.
> >=20
> > [Severity: Low]
> > This isn't a bug, but the commit message mentions using the managed
> > devm_reset_control_array_get_optional_exclusive function, while the cod=
e
> > below actually uses the unmanaged of_reset_control_array_get_optional_e=
xclusive
> > function.
> >=20
> > > diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksou=
rce/dw_apb_timer_of.c
> > > --- a/drivers/clocksource/dw_apb_timer_of.c
> > > +++ b/drivers/clocksource/dw_apb_timer_of.c
> > [ ... ]
> > > @@ -29,9 +29,11 @@ static int __init timer_get_base_and_rate(struct d=
evice_node *np,
> > > =C2=A0	/*
> > > =C2=A0	 * Reset the timer if the reset control is available, wiping
> > > -	 * out the state the firmware may have left it
> > > +	 * out the state the firmware may have left it.
> > > +	 * Use array variant to handle multiple resets (e.g., timer
> > > +	 * and APB interface resets) if specified in the device tree.
> > > =C2=A0	 */
> > > -	rstc =3D of_reset_control_get(np, NULL);
> > > +	rstc =3D of_reset_control_array_get_optional_exclusive(np);
> > > =C2=A0	if (!IS_ERR(rstc)) {
> > > =C2=A0		reset_control_assert(rstc);
> > > =C2=A0		reset_control_deassert(rstc);
> > > =C2=A0	}
> >=20
> > [Severity: High]
> > Does this code leak the exclusive reset control array?
> >=20
> > Since of_reset_control_array_get_optional_exclusive is used instead of =
the
> > managed devm variant, the returned rstc needs to be manually freed.
> >=20
> > Because this API acquires exclusive references to the resets (which the
> > comment notes might include shared APB interface resets), exiting

Is this true? Do multiple timers share the same bus reset?

> > timer_get_base_and_rate without calling reset_control_put(rstc) leaves
> > these resets permanently locked.
> >=20
> > Could this prevent other devices on the bus from acquiring their shared
> > resets during probe by returning -EBUSY?
>=20
> Hi Sashiko,
>=20
> Will change devm_reset_control_array_get_optional_exclusive() to
> of_reset_control_array_get_optional_exclusive() in commit message.
>=20
> Add reset_control_put(rstc) after deassert. The next version will be=C2=
=A0
> updated with the following changes.=C2=A0
>=20
> -	rstc =3D of_reset_control_get(np, NULL);
> +	rstc =3D of_reset_control_array_get_optional_exclusive(np);
> =C2=A0	if (!IS_ERR(rstc)) {
> =C2=A0		reset_control_assert(rstc);
> =C2=A0		reset_control_deassert(rstc);
> +		reset_control_put(rstc);
> +		rstc =3D NULL;
> =C2=A0	}
>=20
> Do you think this change is correct?

It does allows multiple timers to repeatedly assert/deassert the same
bus reset. Is this what you need?

Semantically, it is wrong, though. By releasing the reset controls, the
driver states that it doesn't care about the state of the reset lines
anymore.

regards
Philipp
