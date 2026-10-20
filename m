Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505533;
	b=1ln68DYPPJ0obDCr74Cfzykl8p8w8w36ifczvFHyHj7+bz3PcxBKU3T6/CUQp+Kpm8fe
	 DdHL3SOApFmpdgFhG7XzvjkVafzBl6T9pJz6aMYL1+Su+Mg6sldh7GtMU2NwCREgYhOz0
	 DzRgkxQZKR2X66YSGhldHAJqDKS8Pgs+oNuRqX9T3ujCtL0Mnrm/MqsdjzBRFAqUTsDgl
	 PQjJ1M4g4zYF0w8UOWbWZcdXa3/FuKf0aiXyO4pMG5LysL7nLbTV5CmK17Yup+A58uxg6
	 2WHF9naiwrJ5OpKOUlBGuZANlNe1cn0x8dOaV63aXb2bTTL/wDNyGCNlfPb9PGNOfsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505533;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=3QPH7tP3KiG6F8PI84uSlU7fqi0gvmo9YCmK+PcQ/Ko=;
	b=Qs/VRz1GQO28WXAQsZNicZzPqa2bOW8TJLPAfJOsSbcvFh/0V6b/dkrUlTbA14xA2RIC
	 Ogs+0yBcUxw+Tx6SXN0n/z912PIDIMyTM5EJXQaM3zajkqER/GbNJXeUCKfSLXf6NzAF9
	 t4Nyw25OyMRlMUYgmsqYnl6yZsEc3QimM3yp0LIgRkJN//HOSrw+OXBeLunO43uTPGotC
	 RjLNV1BmfgzbJyA3ZeY6Cr88FEK8G2rqMk89ilb3X9odc3DuwAfaT1NLyy2W7L53cEPyw
	 GkG83f3QC/q7V6nnkblkY8ElQVvZPZLq2mX1j6MSSQbRP3F7qOks4mUYeV0r4/Ub5TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LWxLT9o4;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C74606D481;
	Tue, 20 Oct 2026 14:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C74606D481
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LWxLT9o4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 41DB71A1294;
	Tue, 20 Oct 2026 14:12:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0AA7B60393;
	Tue, 20 Oct 2026 14:12:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C764E10328DD0;
	Tue, 20 Oct 2026 16:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792505524; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3QPH7tP3KiG6F8PI84uSlU7fqi0gvmo9YCmK+PcQ/Ko=;
	b=LWxLT9o4UdOTVO0xFJ01Dexr4y2VWGevobBa2gpy++e5YMTZ/ms5G8K6BSa8t+WFwXX06r
	V0DWOJCXT3aDKPTK3b0NsQdDLZu75AqjTIcgAdEFaTesl/38jP75gQRzdJFV7wxLXw4T+6
	hP8mSBhBz3CSLlCrm4HZRoH2yimpZk8aFvi6cIXpUEhFZpHH9W9QrmsvhETmsFKVcNhebG
	TQRZ0LjqFQuOHwUiD9gOYeLT8Soldxm7ybFqlz2uJPOYG8PwrIKbWsjfeTacB8wCpqUbeJ
	8zjFc8Q75hreNbPu1lR3snGOsoeirQ0Sf90nqfciPVwvtI9+qcpZL7b0t7KWWQ==
Date: Tue, 20 Oct 2026 16:11:53 +0200
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
Subject: Re: [PATCH v3 6/8] of: unittest: Test fw_devlink with PWM nexus
 maps
Message-ID: <20261020161153.19eb32a7@bootlin.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-6-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
	<20261020-fw-devlink-nexus-ready-v3-6-fd6f1c17e16d@toradex.com>
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

On Tue, 20 Oct 2026 15:00:17 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Extend the fw_devlink OF unit tests with PWM references routed through a
> nexus map. Verify that the mapped consumer has exactly one link to the
> final PWM provider rather than to the nexus.
> 
> Also cover a direct PWM reference to ensure that it continues to resolve
> to the original provider when no map is present.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
> v3: Route pwm-map entries to two providers, use a middle entry (Herve)
> v2: https://lore.kernel.org/r/20260910-fw-devlink-nexus-ready-v2-5-17ac82dbe226@toradex.com
> ---
>  drivers/of/unittest-data/tests-phandle.dtsi | 22 ++++++++++++++++++++++
>  drivers/of/unittest.c                       |  2 ++
>  2 files changed, 24 insertions(+)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
