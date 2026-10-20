Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501227;
	b=wi/4YmZ7Asfi5TzyBHye1BuOA3AKW633KTd6hWJuO9FlfI+37rFLRQJa8qjplClFT8Z/
	 30V3YL5N+yNCTqZdeHz90R2LZSU0ARRAlYInvC7lYXFCCK0nshp8xXuGVjAs1jH5Yfxuc
	 VIrhP0mKb8cmOGSOZZ8+Oe/N379RmXS5WJ14gz45jt+zMtKuGJMnYnggE2L1T0VP7JH88
	 tg5Y2KqFA2pIwPkFEeKM/De3nEPHwpVZtS3ma/aasRzwZinSsbsweFoa0U9mzTG4dLe+1
	 vN3QISv/lIAW3igdVmQfK+J5/4DIC7rcGAAUuC0qbjC1INWLpYFI520svAggPfEAzPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=QCVq48Hz4LWuB9OejIcWVFo10GsQgpT90RAtohh2YF8=;
	b=XYzGwjZGabUZDSnq1hI9pnpAynfw4G3Ma98dNApyM8JcoGrHDoVgO2IwT5whKGJzWNHk
	 AgRNVPWaudoNffNQ98p2oC8rJH9hBId4E9h9i4PIJ+i6d5pOA/zc3zlYSTCq8gFwTExM5
	 vqOYvSRQrKh2gGIevwO+dUISqk4oBJP+HYsSLqqSBPU+ze/f+lqdncRyyvSqjdn/3lWqH
	 cIiNZy9RdVkAePHTNfGCf8WlpBWraOKSUCJ2EiH/AFMexEDPQaTQi4r07/z73Iohx0NN4
	 wIpJcT//OsyB2NcoYf4SlRHK898MnLYcLltk+yR5Zy9ikQjvD3qua7MgjDcong4/aMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ou3lAhYX;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9C60A3837
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A9C60A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ou3lAhYX
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so496269f8f.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501225; x=1793106025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCVq48Hz4LWuB9OejIcWVFo10GsQgpT90RAtohh2YF8=;
        b=ou3lAhYXfr1/j4oQcWn4lcxmFC2fRwECqiBFa15n/+ItE2kULX3IyewYF4VAU/XBNa
         agICyytnveBnQdZlLGNxF+mAP9Dvdw1PLZbMOcxWTfx6p55vqzBSx4TwBEMz+ucjNqRP
         rtEamXPCpH9Fbrsl6t1cr0wDEfT+lzhDKSKaeVQFjXO/7tJEkVW/7pzKJkzCeYoEVogI
         9OYBe7le3Qw8uPChl5GbrmO+7F8/wn1O11gANpi2Q84ck3Kca9n4vQqtAXwcC3/9lEOy
         Uazm3kSlfM8OR0ymWeowO8VC4lNoqtWbjSFRc32wEMm8dtcfQeX1tLpebvBscyR8zipQ
         BABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501225; x=1793106025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCVq48Hz4LWuB9OejIcWVFo10GsQgpT90RAtohh2YF8=;
        b=Omv3b6GH0R3IJwxaLhAIvY0Sq7LTfRSrK3d4k8d5gUYLhHXQOP6/ArNIji1Fvz9wqN
         8mi6B0waGQQGXWVauSj6DYC7WazTB6UYGZVqwexBrqqxQiqT9lvW4GYY1NJM0mADzzf0
         6V09xO/UNbD0CE5Zkyh9W9vxZXvTsTEkZn79egNkwSwoRWfP1QTepzE491fU0yx+KJyn
         GPnOXvbcSbHQhGS/kuLoLSLR4W4AvYHsZkXbGs9K18zGpxxXP1MarOTLOHl9P+KHXLLf
         9G3FZMWfAJClBVEpZFm3i9U+U79IRYOXPXZ6hTLMowyuKhFarvomQgrwjCg9yOq493wA
         15yg==
X-Forwarded-Encrypted: i=1; AKwUvBwrlBsK8/V/HcnrbhLuliXM7JQZRAF82QXHOLRceIlpVrSsK2GwTBptVCtR4hqT/4QeXy9lFPT+WrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUNA6bOBhq0QlUiikdeVYrStwokYUNmmq5YdNdVy/kCBm//BXZ
	oIdJWLZAvyLg3ykVTKczAwaNYufceg5PlHmBWluK7FD4GtymTWNjxxpd
X-Gm-Gg: AYBFou1pPAkPWLMdu8KlH1bhm0DeNSUyTN6lCvyASrOd4NnOokkdxpprtlzkqLUS+/v
	V05W33oTKcjgVYSyyJQl3yUfmYIvCJVlfdN1Wg60RqvRbv56e5NVg+Z+IPrYdB7jouaNiDJYesh
	oyWco6oNhZUgB5AehNp3NlM5nJRoxG/kFZmXXDBPqCL9u95mgyFcuUL8K26rW4IINgvKZO1zhtc
	FN+IXQ496eVGpz0s21ewlz4ACxkx9/uV/xvw/FOFpxkU0Qu4x/eRExOU1w7lLf1ERIeHsV8PIE1
	UhM5uHIvIoCbs49MfXd0LzAvVdXtFr5tpnGAoGkQ15rYCv8ujIohLFDif4gMULNWJGIhWPw99DS
	k4v5bQH1/6T2c0bEfpxbODVWwUWfwdy5gNENTaCumvHraoyshNl9594sCanA/RcoYU5lrwyAgKS
	e5Btfw5j1Kj+8+JMN4eFgkkk+7xCNkhXy+oN7Fueek45T3puxgNm0MS7igWVAZUA4FqUMIr/PB6
	pz+5fR115MuSy6DTVuAgdWy91zN0jXnSI0l1oJB4fgoL+bwmpe6z9vpIj2dY2ATVkebCdT9OpU=
X-Received: by 2002:a05:600c:255:b0:4a1:e478:7878 with SMTP id 5b1f17b1804b1-4a1fa092b29mr12610135e9.18.1792501224980;
        Tue, 20 Oct 2026 06:00:24 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:24 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:16 +0200
Subject: [PATCH v3 5/8] of: property: fw_devlink: Follow PWM nexus maps
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
Message-Id: <20261020-fw-devlink-nexus-ready-v3-5-fd6f1c17e16d@toradex.com>
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
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

PWM consumers use of_parse_phandle_with_args_map() to resolve specifiers
through pwm-map properties. fw_devlink instead parses the pwms property
as a direct phandle reference, so it records the nexus node as the
supplier rather than the mapped PWM provider.

A nexus is a translation node, not the PWM provider, and need not be
populated as a device. The resulting fwnode link can therefore remain
unresolved and indefinitely defer the consumer while
device_links_check_suppliers() waits for the nexus.

Use the map-aware parser for pwms so fw_devlink resolves the same
provider as the PWM consumer API. Direct PWM references continue to work
because the map-aware parser returns the original provider when no
pwm-map property is present.

Fixes: e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings")
Reported-by: Leonardo Costa <leonardo.costa@toradex.com>
Link: https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Cc: stable@vger.kernel.org
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 99381c07848d..53301cdac6a9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1331,6 +1331,15 @@ static struct device_node *parse_##fname(struct device_node *np,	  \
 	return parse_prop_cells(np, prop_name, index, name, cells);	  \
 }
 
+#define DEFINE_SIMPLE_NEXUS_PROP(fname, name, stem)			  \
+static struct device_node *parse_##fname(struct device_node *np,	  \
+					const char *prop_name, int index) \
+{									  \
+	if (strcmp(prop_name, name))					  \
+		return NULL;						  \
+	return parse_nexus_prop(np, prop_name, index, stem);		  \
+}
+
 /**
  * parse_suffix_prop_cells - Suffix property parsing function for suppliers
  *
@@ -1426,7 +1435,7 @@ DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
-DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
+DEFINE_SIMPLE_NEXUS_PROP(pwms, "pwms", "pwm")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)

-- 
2.43.0

