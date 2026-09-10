Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ADC48A2A1
	for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049819; cv=none; b=kEHGhlfx+84S1a0z/Ol/UoaJvGfB1tjW2YLpYbaVcl5kk7A5ST7kGfQCqIW0a9nbNJ/pdXw/RbfsPZTnzz4Gh5TXWm8BIzTN8cDZXimePBBcr0puAGPStXO9VmqyGn9rfD8/AV3ffOrrI0dyMQmukcM4SbhVfoRP+iJ4HnUUhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049819; c=relaxed/simple;
	bh=ZHk+OoghMCoHYA0fAqgJIcS5mK9yxj9zSLOS3Af/sOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6+2zPafHkni1RnNJa82/DdPWlKxoKqlLZxFRkQ6wy7N2Gk4FNYHIoA5lpwOQwdFIQxwiUhoEZewlIl6c+LancX9Okueqx4oEiRwQ6l4/GrMNeL+goHv6QyNS406vId+7DjKhGUwO6UjC3JPGOpfoAv2HoSV/gq+8u2W56al4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJBh6qOR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJBh6qOR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so56114515e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049815; x=1789654615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfkoJaXJRyESn+mlV6qvPjMOAGJjSlzoQyRVAMURXQc=;
        b=mJBh6qORqrE0iRe9+QI0rJvrG0o05/+4qzEXS4PawP2R15wzEA9fgg6EByDgqMcQGU
         NBoKI7a+ShTEBZGtzABj0D/YCxGnJfjL8hGwCKaFgVubId9bqM4W3huDdvY2b8cHnP1l
         P99qJMSjSA3VInVW/hesfdHwnJ+iNdKaHDva+R6sElZ3glRY3E2VvtHs2I+cQnICnT9e
         ddnk6R06xHwROtyVXHq6zXTfdb/C7+zy5H8ZNhKXSznOr8Y+uHbrnfwGNmEgMHJq/ohl
         m9P970I1q/rUfIg8Et6e+IC1ZoPmetgTP2J22OSy9os3NJz0x9fH5Fn4CnTzUhD+RNdf
         WH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049815; x=1789654615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfkoJaXJRyESn+mlV6qvPjMOAGJjSlzoQyRVAMURXQc=;
        b=X/HOnQdGI1mDUUIv6sUWXrv6NlOkaqbqQPXxj4Vu4yJwikn3unPtJgpT3EKCs7zeMt
         lzp1ouK7FYnXeGTZD0M70qqDtDGf7wIZzOuQJQIitxsGMqiR0Ti17vvu1NL1wCynWNc1
         iC1kNbCDKmkpmxOr74gTC6dW2802l4uVA1en/mkdFxOSlffNLelVp2GjCMcxIwifjgdA
         hqqga3N4Z2NeZoKhh1i5WVBWEzh3eFnnb1h4yT5OCCjQYNhwwXDbP3r9AUqTOMJQqEcy
         UJWjjU3PuUaGCN5j4tZhc+8ZQnzk7E52a/4On6k4NYh5y8uAE6u0B/9qX6ZUR/+wMZQk
         Abng==
X-Forwarded-Encrypted: i=1; AKwUvBzuaKl+bEi8124ckeD0rsBAa4ammlpqQl1lDsQiKk+8ZdcYyr12BZjCKdEflhnrCwv+sIAtOW721No=@vger.kernel.org
X-Gm-Message-State: AFuF++kkOTNzmfdhk3Qce5dlcZC929GCmlpuyiiNvORlaLXZqmNZqO/h
	VJbIaY0mRbh5erqDTPOQXAOUX21UXL6bHbbWlLis6mdFpWLDX2vfSWw0
X-Gm-Gg: AYBFou33qN097aI8N1YM9Z5nblieTNOTKYvFhlEujsaBAZiB/s+ISfM9UgbFF/TqFNo
	79CP+cfgJZUlywbeTPZxPFnsyccZOP4iKrgiQwcp5hqpbVLMm9DhG/pXhu6PAT1M/qzGJaBsRhA
	LYE4s4uFxxfFH+rSmLHxeHqqjnWqqj60WiLHQyTKRAnDSL9fgUuOQ2NcSeCC4TfUUebjr2X+3rc
	do2Q2rJYw+l+JssRhPZjDl8NCjkR3n/YoicPpMfbFXHynkbemBryMfG7UeesgDk6jL/l1hw4UNI
	1cgmQB2w/6ymV5dqPMp7cZ/ZNh4U4pjvRWk+N1KsLp6yx/nIwaFI/rzlZDCKyqkmqxBNG61jJV0
	WzfoshYozAUpm9LLr4kkmt+JQccsPh33dVTYSb+vWDNdD9/nQbEP/1JDzhGk/9wZ5W1pR8l3rOO
	TPI/zR23wpd56pXUtQj77erM74vOwRe7c35j6/hH3HJ0qS7SpK40ckvBrhf2KKaJn2xgx5SBqAi
	zQzN6VB67cJ6IcP1HqNPYB/d0VNhGbweEhiqoh3Sjui9bkLemaPheQPU9tT0YKB78FLh9kjKQ==
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr422491675e9.9.1789049814830;
        Thu, 10 Sep 2026 07:16:54 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm293895575e9.4.2026.09.10.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:16:53 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 10 Sep 2026 16:16:45 +0200
Subject: [PATCH v2 4/7] of: property: fw_devlink: Follow PWM nexus maps
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-fw-devlink-nexus-ready-v2-4-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
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
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, 
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
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index eba7e9fe6c38..a9c51d639a2b 100644
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

