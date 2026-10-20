Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505156;
	b=yplX/xrdZ2C+S4eOapb3Cvw4K7BpXAFCN4TPbQhdHPSTH7PQ+GXG9oFJo5t7daZ8en4A
	 K1lETkdW+9GUI47hIi8G7GJ3MgJpDWkp4hxlobSbLT3PBqS8rU4Meqf6y4sQJO8XrLRxd
	 5YT/QUu08HfxargLRGFjulJGdVCXCUoC8DCbxUcKbi7OSYBSCTDecXGPIdliC3P3WZR8n
	 DL9H1MIkky/1kaUkaHG3I2ifmiKVnvLmzhEraDUooAc/5KZkC3FvgTfO6gtZyzt7+3uHC
	 rtmBtZmRm/VzpfeFZ4cnvDw58h61RLtM/2V65TCghT8J5pThwM+KiUNuTzWMeqCmYqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505156;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=rpjlQZMNdbdSf6T1XIM98azVI2gPgzqRqo39bRX6+j4=;
	b=09ow3cjMBx/OvBjvq6s+7Fcsx0SHDXcbYMFm2H0TxqBJ9HsgR7Kf/Ta6KLL0Gm9fNKUP
	 0PyKsU50lolOTMTe1ZxAEFtbPO/mptLpQSlnLp49SUKk4c8ME2v2horE9ON6rxcCzMLf1
	 Pxte1tFc8AAJiuIi/lksSOHT2oVBikz/6CN80TvLHbmwl7RZNzE5CZOPNaGHKUk9mTqj/
	 mc0lOkWryrZyXu8DMxtXTSO+8oStzUaIaJ6GQZRhFH2pXzr4ZGIgSl5NT9zskQe/6ro37
	 cvVz++LBSXwNNkV6RWbiu8sfy4n9LLwwdPfUj1eev6GFRPsLbXebPZdsj5dlC3hkKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="BB/Cgox/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C0606A334;
	Tue, 20 Oct 2026 14:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 638C0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BB/Cgox/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CD31A1A1291;
	Tue, 20 Oct 2026 14:05:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83B3660393;
	Tue, 20 Oct 2026 14:05:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6A6210328934;
	Tue, 20 Oct 2026 16:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792505151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rpjlQZMNdbdSf6T1XIM98azVI2gPgzqRqo39bRX6+j4=;
	b=BB/Cgox/eirjT8+0vmw+jFEYhRemG8+xv5/pINyLVTJpXLFlO9eLOx6q9vwsaLgmKo0bxg
	Rg6nqyqcLFWYM7ecfE9SBAxAzUynfCcnd8b4k8ysxmxAlMp4vBdspyYIziaAYfh+XCdMbn
	IZdCrEFfdIV23FSUYgW4FdHNJic87B0j22lfztOUic3+dIGRCZdMP5zT/FEsZMuxSGFZgR
	N/zSMQGGCUgMX647AZqDwnou7rfO53AmhcNt0xJiq/8DKxkLUzkeryMhNzHZ6NdvF9aU0x
	UlxSLELQqcSca8VMF51emi9XZKunsPeR/gX1iSgei8WhBTKgNwqSm7tJwEPz5g==
Date: Tue, 20 Oct 2026 16:05:38 +0200
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
 <ernest.vanhoecke@toradex.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/8] of: unittest: Test fw_devlink with GPIO nexus
 maps
Message-ID: <20261020160538.15ee07bc@bootlin.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-4-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
	<20261020-fw-devlink-nexus-ready-v3-4-fd6f1c17e16d@toradex.com>
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

On Tue, 20 Oct 2026 15:00:15 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add OF unit tests that call the fw_devlink add_links operation for GPIOs
> routed through nexus maps. Verify that each mapped consumer has exactly
> one link to the final GPIO provider rather than to the nexus.
> 
> Also cover direct references and all GPIO property spellings recognized
> by fw_devlink, including the deprecated singular and unprefixed forms.
> 
> The gpio-map routes its entries to different providers so that selecting
> the wrong entry is caught as well.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
> v3: Route gpio-map entries to two providers, use a middle entry (Herve)
> v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com
> ---
>  drivers/of/unittest-data/tests-phandle.dtsi | 39 +++++++++++++++
>  drivers/of/unittest.c                       | 75 +++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
