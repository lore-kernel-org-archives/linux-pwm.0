Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501220;
	b=aJXrhuZ1jmJFqiQJEmgVCXvJk3Rkj5q/aJiGBeUqIYTEwWoQly+aEQuz6ye/MtTwCma8
	 ekWhJ0oQnuhSwyamE4vJG4mfWCrdIQ2msv4VJcV6Zg0Bnr+5cxeOaa0sIe9A0HrJXJu3B
	 Ap+T5GdpffhS1Ag8tFB1TwzG2M8XEHZStCipNVD4vqTCkHc2gPCbP3xx8RUCGttZiOxQx
	 45bHfwJY+OdX1fcHAvcqZ+6yCxeJOHMu0qbzo1k2oYcjvt6aw5aluWRIoNyWn+2o1aS1X
	 fCeL5jv2gNUWuGIzgpoPPBphzeJ5B6SmOzi013MEXyBKN6KFtzmbAkiagDxsECWKLFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=rW8APe3WvjmaSlpRO1MnJJ5xQdZ7K0W4HoHT++1heEM=;
	b=MO3nZAneuulGGfQi0fiTF/j2zYGNmZQOnSYl/uA/PzOzu/aMrVX2B+NdeCxAXivgHY2i
	 wXcHoTjIuWiYrKOTw3sIB2Bs5isBpCpC3lJWmoS8oLlwhC+aptY3jyHTr5HctrNlxWM8s
	 NMrbiEqrhBw0P9qEyuw5NGKqQEZYj8F0Rvm5a+4vsLPvo52P5xAYd8Cfy0N1LtloxhoEp
	 j9M+VWqygTSSChkfk7KWagkuhVyXinYc8ltSckyz7pph7dbF4dm57Fw00mSkCxTnL2zYC
	 spCX4mU+DAHGF1WJsgIWRhuusmLl6StsmqviRXjJxnWF7SkQ+hS9vCIVL9mOEXhT5PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K59STcWF;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291260A2621
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 13:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6291260A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K59STcWF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so32734495e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501218; x=1793106018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rW8APe3WvjmaSlpRO1MnJJ5xQdZ7K0W4HoHT++1heEM=;
        b=K59STcWF/hql2f7NPHfwC602UYqn9bX++bWCBUJYEEDRIvD4MeshjckkJdr4QD0qD2
         3nS80R4GxGkav+NYb6BNr51Sez0+W2EXV4p5uxt0xRkc5amZXUlt8+m5BmP/Dsbzs64N
         sD0GcfyAnzK0o+ROkYg5IyhczqM6r1J07g7BuvLcmaBYkXzNYrT7R69IN4zbbNNTeuHu
         eXVWkir5zKeuua61pQxQY7MYI1xGVcq81zfd5xhu8H9HwSbOuAx9A3MaymTKhU60im3h
         GQD1/saxj/QwD2lflI3F7BXGBDltRhgEHd4GKUZubZjn9BZVS4YseS4BwFjAbvJUqv/C
         2xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501219; x=1793106019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rW8APe3WvjmaSlpRO1MnJJ5xQdZ7K0W4HoHT++1heEM=;
        b=Qot4p/sI6Q2leI+NbEmWjRmJUcKCvUkLvZCylSGQ5TiHEaRBM8VtekuSCXZsa4kbKF
         2pCddyQ8JNLtDgD9mKzXxe1q433F4LLOrtf3OFwILAfCXCQUQ1W3TdsPf7lFjT/aaLFe
         xNu00e62YQAmFn0Av+pEwVScf7vrZJjBqEVREyEmMFn1RLUxYg1j0V9joh0gekk/quP1
         eCgximNvUpyQZycixW226DAnF0HZZ/lshGQp647xPHoU8uPK/XYC0HW1ZOtWYbbpLwbq
         ehVEEiqu0ovzYsH7sq0CmmxeS3jSG0oTtdwAN13sMJazyy0/aoJaeYGp8RwyqBirQXZs
         6p2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwKfOq4vjN3NyyHe/ZyhAh78BaVwTAlXId7olUpR/O7yoZ8tyBJqxyexD8bjQwvNGVGqwTiAvKsAfg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8HiQB0Hbmzni4lvvgFQyf2mC8Q6BVFseYcIUglBVUJeCNXQhB
	Vq1dq9qj3Pi9k25kSjRQ1nkO/1gPBV6GKfmEuyrULB6b8o30jf9BkJSQ
X-Gm-Gg: AYBFou1e5GR0C8+S4i/9fv3M6GFw5QRgYKjTO2i25UUH2dbbjK0cPgco4CgNUBMnmBv
	RaD1+V/2525ntGvp54hOK6DnBBkOooKagH4FpZWmGjhrmKNDKQJWDH5ull4rj1AkA/Wh0Xr7YO7
	zp7yF+GWRrIFpd7NuYVuWM8yJW6DjG/XLk8njPcmc29XlJJkUALm0dCK1JCtCEN/4ATvomG59jO
	5/9rZkYK5UWn4YP5U3d3fAtgL3q99yZociuTEgqYxqs7I85zzBpwDYgPg/FJo3q+pw3vap4h5kP
	b27W+sxUZqq18isjPCoyjBSNn9zUFmvoMpM2AqwYpqlZMeOV/wLO/cQmU+4pCMYQ45h5r6hABYd
	eRmhcVMF4lYiya4MMK7wBp8a6+6CtJIx+RAZfAmJsKFQ5vF6OHON3M6xW0Irf3JM1Ott5EcWjmS
	Ejrs7VIBzriEBeExgieAhpxnp0gD5/ADGdg8zBFkSNTNIs/LtfsEzJvXeMoPVeO5vO+zoLL9KOF
	LU4MqiZIs3n8ujSjPVStrcUWKE89h1Q6KKSZ6T5BbX3jVblXJxMOFFWFk2tLdZzf5OEcAxqFg==
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1d763625emr222865625e9.29.1792501218007;
        Tue, 20 Oct 2026 06:00:18 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:17 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:12 +0200
Subject: [PATCH v3 1/8] of: base: Fix stack overflow in
 of_parse_phandle_with_args_map()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-fw-devlink-nexus-ready-v3-1-fd6f1c17e16d@toradex.com>
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
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

of_parse_phandle_with_args_map() reads the #<stem>-cells property of the
provider referenced by the consumer into list_size. It then copies that
many cells of the consumer's specifier from out_args->args[] into the
on-stack initial_match_array[]. Both arrays hold MAX_PHANDLE_ARGS cells,
but list_size is never checked against that limit. A malformed
Devicetree with a larger cell count therefore makes the copy read past
out_args->args[] and write past initial_match_array[].

The cell count of each provider selected by a <stem>-map entry is
already rejected when it exceeds MAX_PHANDLE_ARGS. Apply the same limit
to the provider referenced by the consumer.

A plain reference to such a provider, without a map, now also fails.
Previously it succeeded with the specifier truncated to MAX_PHANDLE_ARGS
cells by __of_parse_phandle_with_args().

Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/all/aq1CSswlo57jZpMH@monoceros/
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
v3: New patch (Uwe)
---
 drivers/of/base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f63a9486b130..5abadab22392 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1587,6 +1587,11 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	if (ret < 0)
 		goto put;
 
+	if (list_size > MAX_PHANDLE_ARGS) {
+		ret = -EINVAL;
+		goto put;
+	}
+
 	/* Precalculate the match array - this simplifies match loop */
 	for (i = 0; i < list_size; i++)
 		initial_match_array[i] = cpu_to_be32(out_args->args[i]);

-- 
2.43.0

