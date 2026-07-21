Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38B320A34;
	Tue, 21 Jul 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638374; cv=none; b=ql+aLE9sXIwfNE8YAjM8D9d4vLahurs1HEzCJvQLiuAuOtxwYu7typrpRBoFa+Sx+r6WkHgJThGqS8hy9LGw3BIyaRmUof4PjhaQUKE+yWb1y/5NUNgzd2aDbJsHp9cBuG3Tbrl8gYiLFX/UH7Qr7F34hW1bf5NTYZiDFxDX4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638374; c=relaxed/simple;
	bh=I31UjHf7zmsBT4qKyDZwJbmi2FVKfyQlyRv6uKnTXPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lc6ycYzktaE9EKXOPazfmpnrpSTuA8hLsrzrHMp2myzwhecD8FXfPLItrlFdtPFi+sGuQSw7097taLpc/2gJVS3/1oF1q/xm5VKXPEjOA/ieeBt3oT7Qzay+p+NTlHj10yEYj+V9hesQ0lBK+NsHLWaviDgNkNFqk+Bbd79B2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A5E22202991;
	Tue, 21 Jul 2026 14:52:49 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wm9xp-000Zel-1v;
	Tue, 21 Jul 2026 14:52:49 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wm9xp-00000000Clh-252g;
	Tue, 21 Jul 2026 14:52:49 +0200
Message-ID: <cfbb371050354026869b2c12fe948151220aa4c5.camel@pengutronix.de>
Subject: Re: [PATCH v12 2/4] dt-bindings: pwm: dwc: Add eswin compatible
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ben-linux@fluff.org, 
	ben.dooks@codethink.co.uk, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 daniel.lezcano@kernel.org, tglx@kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 21 Jul 2026 14:52:49 +0200
In-Reply-To: <20260721120848.1247-1-dongxuyang@eswincomputing.com>
References: <20260721120757.1134-1-dongxuyang@eswincomputing.com>
	 <20260721120848.1247-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-07-21 at 20:08 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> EIC7700 integrates the DesignWare PWM IP described by the generic
> snps,dw-apb-timers-pwm2 binding. On this SoC, the presetn and
> timer_N_resetn inputs are physically tied together to a single reset
> line, so exactly one reset is both required and sufficient, unlike
> the generic binding where up to two independent lines are optional.
>=20
> Add the eswin,eic7700-pwm compatible string and constrain its resets
> property to exactly one entry.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 32 ++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm=
2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> index 213fdaef25d9..9a9a24ddc61b 100644
> --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> @@ -20,12 +20,11 @@ description:
>    instead of having to encode the IP version number in the device tree
>    compatible.
> =20
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    compatible:
> -    const: snps,dw-apb-timers-pwm2
> +    enum:
> +      - snps,dw-apb-timers-pwm2
> +      - eswin,eic7700-pwm
> =20
>    reg:
>      maxItems: 1
> @@ -44,6 +43,7 @@ properties:
>        - const: timer
> =20
>    resets:
> +    minItems: 1
>      items:
>        - description: Interface bus (presetn) reset

I'm not sure if that is better than just keeping both resets and
pointing them to the same reset control, but as it stands, the
description is incorrect. On eswin, the first item is a combined
presetn + timer_n_resetn reset input, not presetn.

regards
Philipp
