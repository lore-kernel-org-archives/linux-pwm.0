Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0F495AF7;
	Wed, 16 Sep 2026 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582542; cv=none; b=lqKky2OqI4pehiGdoqxKlVujyqDI27q5KJQU163uXoleQE24HRjg/MV+pKceFSAJ4Rvp7yDSrtxxVaUABfTox9jJb77W86zh9Jz6zsR1V9BsrTOCtwA75u0vvlrSSNmi30jBYe9/FFHzZXZUFhtRf98RNI8D0EsW+jIWbRE8Msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582542; c=relaxed/simple;
	bh=pFHt77meffcmtIWa0mo7JYGiUBIpubFHYC3bOPGr/pM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ik0+N9mFeZ8hF+Mjc1BreancJV+PbpsgnZ0GjDexBwQIwmItAH+xKP3tsvmuSiI2UQIIrcC2uTxxLlvthnEICJJUSTCpRxnU2rPCA8sDimYBlTgWjs6K1gjQKw9se2cKU38XXDdn5CJ9watNnCFULv8PxoZDGTQA7GX0Nx5kTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l20ZG0/h; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l20ZG0/h"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C79D54E40757;
	Wed, 16 Sep 2026 18:15:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8562E60337;
	Wed, 16 Sep 2026 18:15:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EA6911C7B04A;
	Wed, 16 Sep 2026 20:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789582517; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fXWm8AO1Zqx8K5HAKfWmJqHyoaWxllT0O0epfw6paJM=;
	b=l20ZG0/hXzo6SDzlOrXijqxeEZQPIyt18ezMvV7DbGMKnAN/jJcppg+qqvtZDuWlnycb3y
	NCI10RS3R7HgCVU6tVH6Ip40jTjxBcxyH3yleE023p5btLHNHyvzv8hP27LFsz+3puhHhU
	f/aAW+rYBQF5uChFm/0Pv501f8gcbhs25OmEWvH+LKj9QoLvItwL0/cShcKSYfWPQILx8C
	sDb6M8o73RwBHqfHLtysCBkDZj058rumnNMKEoiue4OVGW1doY6mgIYcg6J4R9ROg03q8N
	49HA48SJJ8VGKxKcNDdpqwTPlsjTSiQotmXS6hhu1wpMTlFMP3MYYnc4y0ZNrA==
Date: Wed, 16 Sep 2026 20:15:13 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, "Miquel Raynal (Schneider
 Electric)" <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Frank Li <Frank.li@oss.nxp.com>, Kieran Bingham
 <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa
 <leonardo.costa@toradex.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH v2 6/7] of: property: fw_devlink: Follow clock nexus
 maps
Message-ID: <20260916201513.153e4614@bootlin.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-6-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
	<20260910-fw-devlink-nexus-ready-v2-6-17ac82dbe226@toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest,

On Thu, 10 Sep 2026 16:16:47 +0200
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

This tag is only in linux-next.
Will it be the same when merged on next release?

> Link: https://lore.kernel.org/all/20260807-schneider-v7-2-rc1-eip201-upstream-v5-0-8785f9531cf0@bootlin.com/
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a9c51d639a2b..48e05f7bae2f 100644

Best regards,
Hervé
