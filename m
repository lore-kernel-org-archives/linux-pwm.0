Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7C4746DA
	for <linux-pwm@vger.kernel.org>; Tue, 18 Aug 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057772; cv=none; b=smHy8TrZAfx3wZqn76GYKU1tRBwiAwYBayQIYrleKfgDxMB/dQefPS5kmpxMGEWOoninebNm6uJjzhJfNEalD+8bLYp4/0v3kDyKN3U7Z9KbAhbKuEtjzowH9dmLbPLzCbj2r+hTnIt8pF0QBpw1/ho6A0Lb9rW0wKnMOUQtkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057772; c=relaxed/simple;
	bh=O+uSJ6l/nC8L/Knw7obnre4I+TF6Q0+iDF3z0NVIK84=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KO4KfwJDzcGyfEAuQjtPtlcAwgBO6RlENuykYglSWFgbAKpIlPzIKodo0EjjYI8nYM2qmD7FMQXO14vNtp5r1WQb/W97MkrSBDS9ID8NabBkvhkoiI/M8T2vazMAVITua6+JRP84yOubnPEt/DdGfiiA/s8Yij+CzmbJGgsAdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ar900zU/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ar900zU/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49800c6a846so53741955e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 18 Aug 2026 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787057766; x=1787662566; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XKi7bHvcr4VfrcOT9VHCYlKY9RJwWhe/hZvFzt6Sx4c=;
        b=Ar900zU/LW0ppyVBZSmOh/J3jppGr0qAcApPoUFWm3+qtsjMtGJjmuNePQ9IOp0qaz
         VwXIFuj0pK5lQtQavHV4KYuF1Y4x1aLjyxI4wNImIb9Ze9Rxy9xyYy+irCF8urCb91w7
         c+Ok8Ozbw+0GkEXVtlhii0OOxm/7bWsEy0lzeTfoPckH/7ZzsKdwpGNbAKLd5KHTrBGO
         RubLQYT8F+mKK4tO3wpkVbfAtH7zQ6lCpKfVWZCkDJDKxGAsTkPTsA/aGoALXh1nJL2a
         1gpTTScjEW52o7F4GB6h7R3H6Y4KLD8H21uLumDqMa0g3IW6NVHJRFqCiV/3fDaWtFSk
         jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057766; x=1787662566;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKi7bHvcr4VfrcOT9VHCYlKY9RJwWhe/hZvFzt6Sx4c=;
        b=nNOkDHQUHItWv4UA6VIRLwG3SEpCboZeFfgnj6Ir/aDisaBpNkUhnKlLvDGIoZgqI/
         K7ZQWUMrUg+KMITMi13KFZ1oPzJ0yATtsl5BAuMXzu0LmzdnyKt0lY5LGfkfbywikUnA
         SkvR885K5+ZskBY+4K3mrcxZFwJzymVbwMxEznkxCnhGyh/4R170TWQtPgk1ghKUs6k9
         mGXHXdp5Dswima6NYXXzoUPRVtRyYe7Kzy473WOz9DpSHH2TLbMlFN81OT0P5HSw8w71
         5zV52JXO08ztJd/eAO7ezNkZAot694eZR//Y+OH1FRUCZtotO2jfZasTEQZKBKVtRNmw
         C35w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0hZoCSxGQgmAEsa0/ljfzRWRJitbIHpG6fL2I5kSdgYKxn7mhu9ZlZ/de4y/IJ/zSgS4R5+KdENI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbRBvi4+TPmbMbscuSJIyV2hAwTYJxyxhgS7EIcsTkFaLetP4
	3uViiRWMwtWA4ZW8Ao9TsLyqLLnq13lhBVTLu8sm1uCYq+rqjbP1owB+8oZXHtLBixY=
X-Gm-Gg: AR+sD13cAMDwBv1PZI+HiV8z9qhrBM+JausXVDAJohcyamWDNWZqqyXrJIegTUNWm/e
	9zYSRF1O4At3Pss24HjLAVJG0eZSmH6vM4DLfTgG8b05RrB/NbZUZJEBAc/arQMC5RKG7I/KeE4
	FZZXVD/d1fvbuFt4KGx3PQMe1V0izyroAy8nErlxI+I1+33PB9jmLoGBBBkRtaXb6NOBK8xnvfI
	TVQrohc/NVLLKv/boj7NsuVh0JlOyGT+6Fw5NdaLXz6R4aI1cKI2FzXWqRUiimXyOuN+z1WaPeS
	UjmGLL8bCoYJU9EMLF6isrkUG3ZHUBbI4euehYRggfKgKvb4BOL0bn8HR4cfeKe2J4bkeBOQGOL
	j27RyfSIxWd6AcEDT6iG41qtttTZSbXRp2WYqhEyeYglrIVXrMbTF1Z+47OC6jeFbhsHZ9Kkf0O
	+C01KOWZdQmnu0VhtOfVE4bN3TQ6bTnV47a6S9Nn7NSgth8PYTZKDg5f1xFRYtSNhSAABbsRmA7
	3hIXdlTy+d7H+4y+UPyzrs=
X-Received: by 2002:a05:600c:848d:b0:499:48bb:417e with SMTP id 5b1f17b1804b1-4998933fd6emr506661115e9.2.1787057766181;
        Tue, 18 Aug 2026 05:56:06 -0700 (PDT)
Received: from [192.168.5.218] (82-230-44-19.subs.proxad.net. [82.230.44.19])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb85csm174771215e9.11.2026.08.18.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 S6 S7 S7D
From: Alexandre Mergnat <amergnat@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Junyi Zhao <junyi.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260521-s6-s7-pwm-v3-1-57b073fbafef@amlogic.com>
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
 <20260521-s6-s7-pwm-v3-1-57b073fbafef@amlogic.com>
Date: Tue, 18 Aug 2026 14:56:07 +0200
Message-Id: <178705776742.1733024.3702017266095180404.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=350; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=O+uSJ6l/nC8L/Knw7obnre4I+TF6Q0+iDF3z0NVIK84=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBqhFZsDxMqI5GgmdAmlfldDO655rJFQTxUUPF+L
 d8MIqjEDa+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCaoRWbAAKCRArRkmdfjHU
 Rev8D/4xOPZLHUSXNhR9N4UAExW6eRzrUxnLfXcz5FmEunI1yUwDmFrVmLEkd41Pw64v3pthjd0
 iJQ8cYZbSy0yN69vhnEpXL0QHSSG9mXNqanBUNUCaCO+UWYu3TaC2305lJdH4WAFuVQAJvHRGfb
 9P9tFBefF663jGQ044idMqlUX/XYhiggcyPZeckQxpNJ6jTukcTWspEtbDi17EJjKoIQrHlpd2Q
 YsXOXCTNPdOSBNqvm0bwkg7NyNNqg4/6iPUUUZBb6BIA40aoABZyG0AP+IzDTShbYzkTyj+Av3g
 BH6u158isBZyMPTWw2dOh+8J+PSKb6Ems/rCGbd7AdTfn75NevMvDNXLE2KDVY/MDMiiZi/2bOD
 N+5URngivCT7AswNqQNEPLldxpn8tz+ZOSOuzCTcaTNIuqiaERtLBPPE8epIaP7CFoyDfOc3j0f
 7dERS4NNk2d9aMkiAiPtXdv4JMNSeGbDqdLC9JwfzJ02UbfbUmU0EGWKRQ7/l4JeveRzg4INCw8
 PXhs0QU5TJS99upeIQcH/wCMgaudjAz69F6hz3Pa5bfIVhwNkYZb9JXjWdDXgY6bPhzYg68j6Gc
 WZd2Z6EZd1hI9dlU4gd+7yWvzKlN2d5cNqeu2Q2+BimNmIA8p8zBvUDPxKVRvcnEKRokm9HNQlv
 PiLF74xfWXaTQ0g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

On Thu, 21 May 2026 08:26:58 +0000, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> Amlogic S7/S7D/S6 different from the previous SoCs, a controller
> includes one pwm, at the same time, the controller has only one
> input clock source.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Alexandre Mergnat <amergnat@baylibre.com>
