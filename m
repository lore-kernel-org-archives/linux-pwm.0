Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983601;
	b=DqN4VPHFDZs3GCWDSUnT/cs4z164e5AnQwfQn6S3hjUfOmjson9HZw87clqTsWj4uZZo
	 9GVTwpgeuVfeIcHH3vKvSWS7GIqQFF+Yt1o2ZlwtPwcFldNyvjH8HOSAOXwEAdjr2G6g+
	 ukvEDkoSQNZRbd7DsHCdhp/ZpQDubHmTYY3tAj0k6T5xhBPPro60qdVB3v9FYEOFhvhOo
	 dnGBmm9tk+7PpYmPO5UXCSucWdlHCaYLjzilqBj2g6kVbYRGECzuhJDZJzqVbYUK4XOyT
	 AYmUvFCuCOfY5dxtI7vgdhuGmVGAvo7yW/bKtS1q+Ck5oXvnjZq9BZ2pIWSSGl8p/wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983601;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=KfozTBdGMdgx/58U8of75INkhP+6ALogqnpIMvsQqTc=;
	b=nIGpWRDIKurinsNS+T1h9Mc2epFFQ7LaBKPJHoYY2ZXubN0iX2eXNF2kO6o9jLxmowoE
	 Uefjm7XEOEIGCKrlxy/vbCIGsiQkVjvTZ48U4AAMSGPMJLycTZFzJe/XQ60Esd3WKWwAJ
	 qeXPwxTwoT2BQzxG19oaQTITDgY2jujAV/VIjcivKKyHejQb7bbvlfvZNJHiNdJmIfuDy
	 vkI7yAbzL6uA0d0grSLWch6syNkXyk4Z65m0mzupQQwBj7X76bwsOtdvotDN7Frie7hWG
	 Bk8YeD+n6eyP6SRLXI7oz/LOnEJNk0QQF9m5r4FHPijpJQoIF1tbzScszzbDjvThvFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28804606A32C;
	Fri,  6 Nov 2026 16:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28804606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLlSb3c9lz8Xrrb;
	Sat, 07 Nov 2026 00:46:39 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A6GkXow009797;
	Sat, 7 Nov 2026 00:46:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:46:37 +0800 (CST)
X-Zmail-TransId: 2afb6aee046d6f7-d1653
X-Mailer: Zmail v1.0
Message-ID: <20261107004637406_Xz49gRWryhtXYZWcyE7M@zte.com.cn>
In-Reply-To: <sashiko-outbox-201810@kernel.org>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn,20261107000733118AdMi1NdZNf834PvT-O3bC@zte.com.cn,sashiko-outbox-201810@kernel.org
Date: Sat, 7 Nov 2026 00:46:37 +0800 (CST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>
Cc: <laurent.pinchart@ideasonboard.com>, <heiko@sntech.de>,
        <ben.dooks@codethink.co.uk>, <benjamin.larsson@genexis.eu>,
        <nuno.sa@analog.com>, <xiaoning.wang@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <sashiko-bot@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzVdIHB3bTogYWRwNTU4NTogQ2xhbXAgb24vb2ZmIGNvdW50ZXJzIHRvIHRoZSAxNiBiaXQgcmVnaXN0ZXIgcmFuZ2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6GkXow009797
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:46:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE046F.001/4jLlSb3c9lz8Xrrb

> Should on be clamped to 0xffff before subtracting it to compute off?

The period loss is real, but clamping on before computing off is not
correct here: it turns high duty-cycle requests into 50%.

The period is on + off and both counters are limited to 0xffff ticks.
When on saturates, the current code keeps the requested off time, so the
output stays close to the requested duty and only the period is
shortened:

  period 131070 us, duty 131070 us (100%):
    current:  on=65535 off=0      -> 65535 us,  100%
    proposed: on=65535 off=65535  -> 131070 us, 50%

  period 131070 us, duty 131000 us (99.947%):
    current:  on=65535 off=70     -> 65605 us,  99.893%
    proposed: on=65535 off=65535  -> 131070 us, 50%

Above 50% duty, keeping the off phase is much closer to the request than
keeping the period; 100% is a flat line where the period has no meaning.
The pwm_apply_debug() "best available period" warning is a heuristic and
does not justify a 50% duty error.

I'll keep the current ordering.  I can add a comment explaining why on is
clamped after off if that helps.
