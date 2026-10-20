Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506231;
	b=Q8HpB7HxopqrCYQIQsSTpVBXBrxPqavK0Vdq315OhkL/7lWVyWSbS7ULO9mn1lgDzDjG
	 BV8dwfZoOyQoQtsgS3xsYXBQ3MuFLQUahd2jrdMd4zCWpft9uFB5W+gQzxsLw32aQrQHy
	 C2e3cDAJwsoBUvRlLrtxepzw86mhnXQk3DXbK1UUuLHJyA3EGBAuPPtCSkO6n8qGXaLXM
	 fWR2u8yVJOXMsixOZKTiAHHAvx+l3eBL/9Pn4unLZWPqfEmIcXhpATZBCq8RjqJu/h/iF
	 zugiQPuPki9FISlMckDTJpAuNqSLJcwdE1JY+dPDMvt6IoLmEirSWDH6Jf37zIKnCVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506231;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=nIoCWNv4xGoCOetkLvsqI4aUF4MRfL4xBIuWjDY/SRg=;
	b=Qc8AiSMGWntSmY8PN1Yjvw/gh0ce4hkiLeJS0uEA80GNpEX9GjLAqE+2Kd+7nffXQI/t
	 7PJNoxIyDkEpox+TXoFSaEC30fpHKValfUWdF/riiyofuXq3/W6lBadvsiKRLo4EwF/Wj
	 nLmkTI8XgpCheXLw5DucKX+qJzaE/lYzqH/VnnCYJX/lNcpYEL0IHPcG+n/gf7XKOYKWU
	 KKAWyTaYD1ToyZf4RgF4ljApyCILDo/SEQ17DWfFlRMEHp5bR1AVN7pnioO5+yLTozwaJ
	 +bEJhwm1NeD5oDxECv7VNVOCDXQ5Exqr+a/GkVDNQXaxCLMVpiw9aXdCkefWqtYvKOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HWESPOVv;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE56606A324;
	Tue, 20 Oct 2026 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE56606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HWESPOVv
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D9BD4E41289;
	Tue, 20 Oct 2026 14:23:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCF9560393;
	Tue, 20 Oct 2026 14:23:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3472610328934;
	Tue, 20 Oct 2026 16:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792506226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nIoCWNv4xGoCOetkLvsqI4aUF4MRfL4xBIuWjDY/SRg=;
	b=HWESPOVvZ1YKTS4OCRK0Zwy4TnyNs8HUtJq4nfFSf0L/ljTdeMqZ+qSoUonOp5ALKK6/1D
	bO3ewYux7JoZQsNcHuo5adDdQq0E6wiyopXFUn9qKKTjK92Q+5JLfrnAsumiy7ZRdmnHHR
	fkCwmYJbis17XhjR7Uayts8fELwIA1wgiNETrMzaN76HFWcZfe1du38o0QQ8F/qs/2Q9+f
	Ru8U8ZpQ/PsbLp6NJJFszbrnStD4G3bV3jeAca3fITiAY4HWuXl0WO3IRQKD+Wk9UkrsfB
	oBWtHB8nHCK5LCxoZ8v0cPj1Ar4LZzFMCiUjiqAWFEOlP/XeswVoEpJZtVBYMA==
Date: Tue, 20 Oct 2026 16:23:31 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li
 <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonardo Costa <leonardo.costa@toradex.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH v3 7/8] of: property: fw_devlink: Follow clock nexus
 maps
Message-ID: <20261020162331.379474aa@bootlin.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-7-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
	<20261020-fw-devlink-nexus-ready-v3-7-fd6f1c17e16d@toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest,

On Tue, 20 Oct 2026 15:00:18 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Clock consumers use of_parse_phandle_with_args_map() to resolve
> specifiers through clock-map properties. fw_devlink instead parses the
> clocks property as a direct phandle reference, so it records the nexus
> node as the supplier rather than the mapped clock provider.
> 
> A nexus is a translation node, not the clock provider, and need not be
> populated as a device. The resulting fwnode link can therefore remain
> unresolved and indefinitely defer the consumer while
> device_links_check_suppliers() waits for the nexus.
> 
> Use the map-aware parser for clocks so fw_devlink resolves the same
> provider as the clock consumer API. Direct clock references continue to
> work because the map-aware parser returns the original provider when no
> clock-map property is present.
> 
> Fixes: aacc54c67869 ("clk: Add support for clock nexus dt bindings")
> Link: https://lore.kernel.org/all/20260807-schneider-v7-2-rc1-eip201-upstream-v5-0-8785f9531cf0@bootlin.com/
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
> aacc54c67869 ("clk: Add support for clock nexus dt bindings") has been
> in clk-next and linux-next with the same hash since next-20260907. There
> is no build-time dependency on it, but this patch should not reach
> mainline before it.
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 53301cdac6a9..2388d607136f 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1422,7 +1422,7 @@ struct supplier_bindings {
>  	u8 fwlink_flags;
>  };
>  
> -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> +DEFINE_SIMPLE_NEXUS_PROP(clocks, "clocks", "clock")
>  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
>  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
