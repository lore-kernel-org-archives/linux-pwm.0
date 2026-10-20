Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501230;
	b=qIxptjReAdkKmv+xHp8rQfKkeQKX13KEKN8MmJvCQnpoOyjHEMI18OCsu0VqRfnas5Rx
	 NzTQS+aCkT8iRQZ0lBdmoDrA0XRKs6kae8PZ2vRMb6lCv15avPhufSBbhxDukn6XOY599
	 rhFjWGunqg8f0je/Pq303wHk/Dey66c+s+vdFqDBeCQ7HT7yZZ5YfXeVJYGqgwXzsWPAh
	 WuE33MthrmY2jDYbxwUuUMJOLd7nHu+945MrZikNkbpmRm1+Xb1dOfeADZbC0b0D2nzO/
	 HDuo6V3Z6jGcgK97II9NC43Ka8XDI03Xlm7QOSZHBrCoUIFLX+mStHuk+/qZLMqi/zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gDnFObZ0K2X9/qO2ilzZd80c6UZ6TUK8OX6LvufmLAA=;
	b=M4RvgXewy+71Qq/b3bKOcY0x271j9Tcwffb6aQa5oOSGVoDwqxHmvA1JBq2mzOkypDm3
	 U8syD1Rco2Twjf6dQojgHyyQAatPUtbmYnrjqUpvsHgcDGxdbNNnD01ApczVbwLAA9/9s
	 FiJ3onQ+SZVRGDOcBw6VlMi3RK3hoTXjfz7PGcPcI3RUHgkzngO0VKxhGtRgZo3y8bCom
	 lZurQJLggk/G+hFkbBLErINXYSRzvaaSWtuBAQN78jiULgafu1JhfvYMp2inXg1tpUFeW
	 tMrzaOvy4ma6H7qxcGB1h/+Agu/9f2Z0iI5tqZtTArCFEvKrLy05I2llnl6p4kKcdsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="p4l/8DF9";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21060A4AE0
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 13:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA21060A4AE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p4l/8DF9
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1689281f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501228; x=1793106028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDnFObZ0K2X9/qO2ilzZd80c6UZ6TUK8OX6LvufmLAA=;
        b=p4l/8DF9+/kYzcvHQwOneewQdIXFBAmaAIofNK4rYogA0p6b2j/4k28KAy04iAOQ+v
         Q8+DfkO/hKDcSxybfRIB/8oGAkscX0EMrg0N1JIRBHIhmHjDxc7gpzxJvNaM7uamfipj
         FQbgA11uYbN+ERU4IiiyOgZhWX6v7sRYJZBzWkuMK2EVtHtek6ObeuyA0FbWaUBVRg2i
         iOaFZ3M+c9VQuy1OxKyUIP/kjUGSLEheSnAiCfnKqofRPPslBWn1sMhSPAK3c+dq4AQf
         5Aer6fU9gvSOdpYJw408drds4U9ySb6zuO/55i8bNFqdGjukPkM0kDIdyU0IuHXi5plR
         W0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501228; x=1793106028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gDnFObZ0K2X9/qO2ilzZd80c6UZ6TUK8OX6LvufmLAA=;
        b=IFuqmEnFweq01s6AVWmgjIcpGcLJzPfbflUAZ/zLdIpeMhlQ07+vC9RlbO7Fsgu+H2
         xYfKr4cvY7MIkqhOmCT0AMrVecF4HYS/o6Qodzzx29jNHquBLIQ/rUKbk1z49zl/XkH5
         7O3XvmO7HCHXpIzxLz5TEWYaxWTASSioJwgKy5qMq2PixB4hvjAB1W5ZyPjvnTOl7S9P
         f15Eef4Nh3+fMiAfDw8Q1jhd1TiW6QbkWT1abqbASASobk+hnPgYD3KxWeKg3dJYMIrz
         O2SBUMgdLGNSowEJq8IgvMW/ahIHLFkya/EhyhEH3Q2fGZEjJhFwuw1AmpfdT9MXb1dO
         54sQ==
X-Forwarded-Encrypted: i=1; AKwUvBx073DsQxvOAEg18wptLEex7PrDg7tQi7eMbIq+tKaNwCoJjDFPP75tS1wlTSXH8kqBF/LCGvMe7FM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUjQjNVRCBP+a05rK1CsmfP0RWFp8E4LaQ2F2OIB7KKMGpRe3H
	htQZC+9PIxWwKBYkXgAlBJBpLoKO+lQOZV4AH4J1dla6STztnrgfnSx3
X-Gm-Gg: AYBFou1vJKgaMB4UNzghA+i8lMU+nq/3kuE2oWoeBQGhYr07ULYCBGjBni7w3/yfcBA
	yrYsUfjFaXAR5T+59jIqGhelZF6bFhGkFHiH+ePMEbOyZarj4I6af0o6t5Qh8zFgeCA1v/ymVSG
	RANms3T0983F9Q4qkBxd+IzDlJTb0kajywqXpqjy1sMHeonGgzPkZZtt+i46xzNjR1AOHFIvRKv
	g+NGxpSLlQrb3TQ+jVNdeUimzKvnyZ1qy1faKEDXVxTtu4ow1Em88IC4VEeRzQO2QVc61A0/rMM
	bBa3ziQeYQEdQyGpIYF+AaEkAHCi6sgo5fltq88IE1CVXbusUy+GsCHyioWseEcVcMZ54NYDnDa
	Zf01cDjCmJrZH0Sr5WhSLi9FIt/WAcVsDFO7P99fv3Z2+zwoOoi0T2AeY+kmdT93ePj+PirPlOx
	/6cPCCvCW5TP/urluc19qORjz15TzAPsOAyYM5uCoMu0ll5TpxB5UV/TaQh8yIG6xrs3G8HRnvp
	/Xc9t577eY/TKmfI3D7KF19Toop91gofDSQDSiI9yVR24pKkKKJvKc0S8HlpclXIGpRmE0JSg==
X-Received: by 2002:a05:6000:4205:b0:48e:dee:52bc with SMTP id ffacd0b85a97d-48e0dee52f0mr18975446f8f.0.1792501227440;
        Tue, 20 Oct 2026 06:00:27 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:27 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:18 +0200
Subject: [PATCH v3 7/8] of: property: fw_devlink: Follow clock nexus maps
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-fw-devlink-nexus-ready-v3-7-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Clock consumers use of_parse_phandle_with_args_map() to resolve
specifiers through clock-map properties. fw_devlink instead parses the
clocks property as a direct phandle reference, so it records the nexus
node as the supplier rather than the mapped clock provider.

A nexus is a translation node, not the clock provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for clocks so fw_devlink resolves the same
provider as the clock consumer API. Direct clock references continue to
work because the map-aware parser returns the original provider when no
clock-map property is present.

Fixes: aacc54c67869 ("clk: Add support for clock nexus dt bindings")
Link: https://lore.kernel.org/all/20260807-schneider-v7-2-rc1-eip201-upstream-v5-0-8785f9531cf0@bootlin.com/
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
aacc54c67869 ("clk: Add support for clock nexus dt bindings") has been
in clk-next and linux-next with the same hash since next-20260907. There
is no build-time dependency on it, but this patch should not reach
mainline before it.
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 53301cdac6a9..2388d607136f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1422,7 +1422,7 @@ struct supplier_bindings {
 	u8 fwlink_flags;
 };
 
-DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
+DEFINE_SIMPLE_NEXUS_PROP(clocks, "clocks", "clock")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")

-- 
2.43.0

