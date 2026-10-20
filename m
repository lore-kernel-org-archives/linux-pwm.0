Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506475;
	b=VJ2MxDte/sfdmtKhx9qlv6GbEA7GoJbqTGHVL4RulH20IbM/wgflcncXU7XH7jZrWJVC
	 e+xxrlEaddJXIm+pSxGX58jOd9DiDJxvhfxqQe8Utwkx37Py8jytm0qEWT9vQ4WryzmyI
	 ZFj53V0ycJqnHKd+HkE+K5mx1CM19sM1+sptMvFArDchrNwa24DN/7GJov7xnjuncxYyG
	 m2Nie4RqCMkXyb0ZO8CRG07LikMkPOhbLb03hWvMZjj9bB3MzMLzZB5+05CdbfPw/q6Im
	 h7hA17jats6ndgkM3zaneEnfuetBCksFSYy1S+vE98arwzevrkA041nJJ21Q4or3dTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506475;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=kmBy1fe6LI5oXiYPbhW6SzvVcy1Ogh5pT6iC7mSTUOM=;
	b=iqhAaowsFuSheDTjBF82cZzsJQKkI7+Qh1DN+xRkLGDuvX9d1DhhJxvVZ6EtpaivIepV
	 /wNdB9KVfuqr28zm1gZKqJQdkUJneO/1v5eBLlS74Lf3ZpyH/FYrF5iPakpfxDpNIv4oE
	 oxIxcyNotvESVgm1KBlC6pVBunO0+0AGTNVJnZiG7SPzcMtVN8dcb8/XllBGJeehZLo8d
	 ip8kMqEK9IQ+z0UvZn0oub4bqJorIZGmvuBaKKeCwlEpjS953+NM+lWpxowdTCzbIQzk2
	 XD7tivFrZp51wXG/gj0QVwuEx6f/fXm/406H5KYobNfh2aiG3prWrTJEGr6HKi08v/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NfM2biC7;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90998606A338;
	Tue, 20 Oct 2026 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90998606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NfM2biC7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B21D14E41289;
	Tue, 20 Oct 2026 14:27:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F49060393;
	Tue, 20 Oct 2026 14:27:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 189CA10328DF3;
	Tue, 20 Oct 2026 16:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792506466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kmBy1fe6LI5oXiYPbhW6SzvVcy1Ogh5pT6iC7mSTUOM=;
	b=NfM2biC74Dx/3Yhz14WigU8d8Se1zC9x3KPteernMS0aBrwpHL8t3yKKgjtiBK85V7smNT
	0Sr9jRAbaL9fqQ/uQ/rMQcXSrOYyw1yQM7p+fOcPTul8INOTsWuurKS36mhDKE8jc5iPIM
	QYBr8EgEqLufOp1LinZOCiCxEAjrJUvDAwwFQ+8AMbVTR4kMRDr13CojOEnUaf4Go0VuhC
	MBW7l3V8+w38SkAw4YMpqfSk8993bPpdLGHcnIoAVjLdhgrowvPxBN7or8GBqDiNXDBn12
	LVSUfGRDPbpNeEeTJENkz4ZJ+UMkjSKpfa23KxeYxR6nO66mEK6EhphnczYZNQ==
Date: Tue, 20 Oct 2026 16:27:36 +0200
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
Subject: Re: [PATCH v3 8/8] of: unittest: Test fw_devlink with clock nexus
 maps
Message-ID: <20261020162736.422fb5b8@bootlin.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-8-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
	<20261020-fw-devlink-nexus-ready-v3-8-fd6f1c17e16d@toradex.com>
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

On Tue, 20 Oct 2026 15:00:19 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Extend the fw_devlink OF unit tests with clock references routed through
> a nexus map. Verify that the mapped consumer has exactly one link to the
> final clock provider rather than to the nexus.
> 
> Also cover a direct clock reference to ensure that it continues to
> resolve to the original provider when no map is present.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
> v3: Route clock-map entries to two providers, use a middle entry (Herve)
>     No clock-map-mask: only clock-map applies to clocks (aacc54c67869)
> v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-7-17ac82dbe226@toradex.com
> ---
>  drivers/of/unittest-data/tests-phandle.dtsi | 20 ++++++++++++++++++++
>  drivers/of/unittest.c                       |  2 ++
>  2 files changed, 22 insertions(+)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
