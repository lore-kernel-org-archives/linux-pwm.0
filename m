Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920269;
	b=1FnMM2d6DU3CHa1kzzdlScbDmqzlwb8Wqzii9Mk+MJdF7nbAowaTc56OvqFlJspWUIbJ
	 Vwalm6xcmapjOaazj9Bd7rday8vn6376tN0btGWBiam42a8tZ6PmgWEohP2c+wjzeo7wp
	 NSED0oRdoRi128vgZo6+AhfdrnZD3Fmn4g5CHTuzYnvL+6BhTpOmZR83+JyHN3qDFd0+5
	 uc1Dfc+edOoCSIE2/CrP3ekB8GrP7fALpjHm2MDhyz609GByNImhaT/i+qSB3tlPcRWqD
	 aOBJ8PM9k4LUZXmCRILZXZKugRJqtEezV9BkwKA0D37Pwsuvv7mtPzk1769zY62q6YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZlelFqtSwzH7qLeRIoPSb1dB65eEiaq1xmBL8y2J6Sk=;
	b=Bkaasz+udKJpjBWxUV1j2z6n1OF51eVKuq3q8u2HZgPsXwVlqnpr9PxG1Ej2faZDyyFU
	 bsmd4REzexSZ46fQlVl3P1s3LkmWikNEBhgKnVOZLebZKF8v8ofIqXabFe+v9Qb0CdGjH
	 tEseTqBdSkMDneveTsyXfB93DauLuBoyS23Lq7rmbaTGG3hPu42JItU8wHbdvwor3g6EC
	 2W0J6yk3WNzEh8ztMLX/1TRsmeMy0MMXys3IAsMaUewb5VOqqv0xOEIUrjw2pTY0UDmuo
	 sme8EgZLV0NQXW1SYt/pcOz+WG9MyQXYCbKYKoEPUD6tx4peND/JmP8ydEHyTE4XjGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DQbT0sOJ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD742606A338
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 12:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD742606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DQbT0sOJ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3791619605cso8289110eec.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 04:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794920268; x=1795525068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlelFqtSwzH7qLeRIoPSb1dB65eEiaq1xmBL8y2J6Sk=;
        b=DQbT0sOJQ7QP2QSpio2o9wdDmE/fEoD7TkjFqt9pLg+kidMYB7mWpnHPZ+38Fo5pOo
         pSefdBrNecz9uCbYFbmVP0TYvoQwQFb/50s+SfoDO5UeE4kkNl3jjKyS6siv8CHVmCep
         DlaHs1wubkm29ejkWHosp/6doJ3BrZCqw/rOWNxjthh9+WnaaPxK6nN5rvwO6AcqH8LI
         EFy0cZkysJWFSiJ7uRP5S+IPN3iuC05HymhTwibT/ZnL3g8C19RfbHZY5gsVmwyr33t2
         fEAGxVQhEpDoAx/Gp68qAWZ35L+iY2geEyPn7PqSIH/ugldcJu5a0zi0sQv1JBKv8QOZ
         vJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920268; x=1795525068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlelFqtSwzH7qLeRIoPSb1dB65eEiaq1xmBL8y2J6Sk=;
        b=kb0tzLMCzifKDBPz5uaCHUtG/oNJC2jgpzdSMja9JUA53LPVd/KGrMn1whsbftF+x6
         iiY/T1HKXXFiyj0IiZeCQCpHbwXMhmvCqm7LWaGW6gKhJgj2d94KjFyLbmWCwKsOA31C
         LZpTNhSXmNmleXyXb2K2pLjLidS4tXPDanva4Tx87RbFmI0sZqvZeBJM0VN/dTUL6nlz
         fzSfbW7YryFlOjIbB8BlgZBbBqJGhrIu9jU4+t0PVq2X+ZNa96lvnE3Ag/6WKdfM5/vH
         53ahVXsCP1WmdHw/QYccJKibt3GS8Vzyg2VCTiPZrKsCy1itfgC/awVJ2SnXlvGuHKqi
         xX4g==
X-Forwarded-Encrypted: i=1; AL+hErGXY+3rAosJheb7/WAfe4gUvK9rLffhIeQnA4iTWBu36BcCkiJrf45x/+OqEbijolpErpi5vnqBonM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EHoTiwkgPlelQGkAVfG7H8dD6N3zoq+QNvKEMQyiFVrSmGeQX
	fYmtnkZn24e+FVu82r1XNJWpb85T+m4ZQSZTUy2xaEAUKj2ROeAMiUi+72AVIpQ15zo=
X-Gm-Gg: AZFdTZfuXV9OKN1xNdQ12i7zbEfXcPd5TiGxmR6rLTtDKCoPVYQY6L6Dw3arvHlE478
	zNJDgcaoZfSk5yawp+lbcpFBIGJNGaT6BzMgBjeV2tGclSA/DA3aP7IF3Q7CRvMbTosGlFLnEwz
	Q1TG+9gC3c4piOqFOHNjvoeoCO0alwaSxDzW4o+N5ALkyrS7zmzC469nhFoC/5oGUElsNfjVs6w
	6WsN+5ipXzL9AtwjXNJnYO0rfJlP/XqHDX9rAUZejVoTWdaSX+ZMlu3xZG4OVbZPXQYq8x9eI0F
	3mhNQAHfIFAgw05b1dFNLaal5p5XpzVU5tzIOQgIDFqZQaHnvJLfATvl9zZmUY27GHCqkOdo2Gz
	H4JJwMUnfcI9/vfnUUixY4hNOO27zfBoG9RdcNjr7tVPPmLjq5fdVyfBKhjwVAP3Ppn8B5iLpJZ
	HbO3z17CI+uvaYjyKzPapwnQc4S0zRm+vLbd5JuhkBgWD4sdqGm+0IZQIXOb9Ckd5NJuutcdl3C
	RmucS17+UX8F6BV0NGGQBzK3iYCJDo3SDYMjmcTdzWwtj2UQ4r3JQmCJ/WSDIFvbJ4qawUq0qYa
	cbYoss2pmNNj2Kll6mb5uJdcxsaqxnfbiCSSWsC0FBdfFQ/TJZKij6itI+L3efLnecv1c7iJ2Ju
	8A3ZqxbVHfIX4iQ==
X-Received: by 2002:a05:693c:4097:b0:36f:d53:cf2f with SMTP id 5a478bee46e88-379635648f7mr13425750eec.1.1794920267749;
        Tue, 17 Nov 2026 04:57:47 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::a1aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm44767034eec.11.2026.11.17.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:57:47 -0800 (PST)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Tue, 17 Nov 2026 09:57:15 -0300
Subject: [PATCH 3/3] riscv: dts: sophgo: cv180x: add PWM controller nodes
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
Message-Id: <20261117-milkv-duo-pwm-v1-3-3f1786ea57b7@baylibre.com>
References: <20261117-milkv-duo-pwm-v1-0-3f1786ea57b7@baylibre.com>
In-Reply-To: <20261117-milkv-duo-pwm-v1-0-3f1786ea57b7@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Chen Wang <unicorn_wang@outlook.com>, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.16.0

The CV180x/CV181x/SG200x SoCs provide four PWM controller instances at
0x03060000, 0x03061000, 0x03062000 and 0x03063000.

Add the corresponding nodes to the shared cv180x.dtsi, so that they are
available to every SoC including it, and keep them disabled by default
since the boards still need to describe how the outputs are wired.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index d2ec70fd515e..c478e7eb549f 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -160,6 +160,46 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		pwm0: pwm@3060000 {
+			compatible = "sophgo,cv1800b-pwm";
+			reg = <0x3060000 0x1000>;
+			#pwm-cells = <3>;
+			clocks = <&clk CLK_PWM>;
+			clock-names = "apb";
+			resets = <&rst RST_PWM0>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@3061000 {
+			compatible = "sophgo,cv1800b-pwm";
+			reg = <0x3061000 0x1000>;
+			#pwm-cells = <3>;
+			clocks = <&clk CLK_PWM>;
+			clock-names = "apb";
+			resets = <&rst RST_PWM1>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@3062000 {
+			compatible = "sophgo,cv1800b-pwm";
+			reg = <0x3062000 0x1000>;
+			#pwm-cells = <3>;
+			clocks = <&clk CLK_PWM>;
+			clock-names = "apb";
+			resets = <&rst RST_PWM2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@3063000 {
+			compatible = "sophgo,cv1800b-pwm";
+			reg = <0x3063000 0x1000>;
+			#pwm-cells = <3>;
+			clocks = <&clk CLK_PWM>;
+			clock-names = "apb";
+			resets = <&rst RST_PWM3>;
+			status = "disabled";
+		};
+
 		saradc: adc@30f0000 {
 			compatible = "sophgo,cv1800b-saradc";
 			reg = <0x030f0000 0x1000>;

-- 
2.53.0

