Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479F3D2FFC;
	Tue, 28 Jul 2026 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238988; cv=none; b=N5SZgwnuW9Dn11u9+4MW/HrJh0sONjM2tIW4DMZYkW+5zeqSZfJ2b6PfD7pNDHUSjtefqxuGgF9BjgJ4ROkuZGuCjV+6/KbVxEFAe3SIh0WVKrL1hu9yUuSuiWGdzIErIO1QQ99WbpAxhZClqFA6ti/TeF4inh0oktW5MxGqaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238988; c=relaxed/simple;
	bh=KGDbccs4wcZtJldznZa0SKMwu1AomHVj0N3nTBPXvcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tb2wfUQja6GF7FvHl7pC20XxphoqkHBdSyvi/74RLnuySAjL2ESeFQnvAhoDNQqYIWUPjPdjrE4R72G36jWhPDhYpIh5brlMMUwkm6TK3FwIJpNP/BavcmASLXRmzw/x/3BQIhAnETcMjq0fAbRH/7dATbpMYFvMxBSoPBw9ZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4270D202776;
	Tue, 28 Jul 2026 13:43:04 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wogDA-001iF3-0X;
	Tue, 28 Jul 2026 13:43:04 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wogDA-000000009pa-0F9q;
	Tue, 28 Jul 2026 13:43:04 +0200
Message-ID: <fc69546788662341418ebe2adb7da3fbedef6677.camel@pengutronix.de>
Subject: Re: Re: Re: [PATCH v13 5/5] clocksource: dw_apb_timer: Use reset
 array API to handle all resets
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
Date: Tue, 28 Jul 2026 13:43:03 +0200
In-Reply-To: <683d4880.8ceb.19fa8614bba.Coremail.dongxuyang@eswincomputing.com>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
	 <20260724084437.1850-1-dongxuyang@eswincomputing.com>
	 <20260724085527.D31BC1F000E9@smtp.kernel.org>
	 <63b2ba86.8bcf.19fa2e572f4.Coremail.dongxuyang@eswincomputing.com>
	 <331adad68e3913cae30d8b1c5764177affabf60f.camel@pengutronix.de>
	 <683d4880.8ceb.19fa8614bba.Coremail.dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-07-28 at 18:59 +0800, Xuyang Dong wrote:
[...]
> Will drop "reset_control_put(rstc);" and "rstc =3D NULL;".
> Keep only the content below:
>=20
> -	rstc =3D of_reset_control_get(np, NULL);
> +	rstc =3D of_reset_control_array_get_optional_exclusive(np);
> =C2=A0	if (!IS_ERR(rstc)) {
> =C2=A0		reset_control_assert(rstc);
> =C2=A0		reset_control_deassert(rstc);
> =C2=A0	}
>=20
> Do you think this change is correct?

If each timer has their own exclusive resets (or none at all), and they
have to be triggered at about the same time (if multiple), without any
ordering requirements, then yes, this looks correct.

regards
Philipp
