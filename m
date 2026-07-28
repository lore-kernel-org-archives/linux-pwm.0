Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700130BF6B
	for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208042; cv=none; b=Ehgh88NXySPqC9ON2I1hWWrwpoj/As0YSVz9Fio6AUMI/25trfJpsioZh2cf1hCJpFCP6DNs40fakiUkdAxZYnnaIva5l9rPqmjG1fp/+ZKgduT1LFg/xC9f7s1cG04I5pW7ihvBQXe+UNa4muywu51YxUOrj3zt0lSfhqbNJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208042; c=relaxed/simple;
	bh=vKdAA6cFT54tLCIgFXya6DLI52t7A+r1YFU+iUb76PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uxQBqvAj01kcYr7yo3HNcCFtwujY9gyoH5eNUQ9qDkmNRcyWpYcoapbHhjjepRHThI31+QU6yRbsh5q53gN0dLEbTGiZ513+nxpTWD2zx35dNmMS6iTj3INjTwti2CoEzN0CC6wAp1Sz6M2K19kzG+jHoUE8gAPZyhTS3MKnKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9VwL+KX; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9VwL+KX"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfaf91daa2so914925e0c.0
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 20:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208039; x=1785812839; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2daEu8V03oHloZq7HOxZbsCrfFEu1YUSaEp/KisdjxA=;
        b=q9VwL+KXqhK+BY0WMQkjPqa9L+mIsUg3Y11wLsMgTqNZSlqyVAQLdHDkFcgE84WDaQ
         Aq7OUEoorbmSg4ATvGoD30CvE1ZX3UB2m+0SRel8M/6ZW+UVu3CULETfry4lRABGwyJq
         McPTVIDqh57xysyR93CSnwhnMYL1QWjirCmg53AnEE/ckrf9G1INSKmHegpLdBkOoGfX
         1YvwyRE69kQQDz1Z1VuE7hf/F8OK+T6XaNLKKgwGvCWNDrTvRSVGrAG/y9gw4jQfBWBA
         qsBUmT+R6jDr8KSMK/DxcG2wuAnjecztyS45rnoglYp1SHN5HtWXZ+xOpjGVco/QcYfM
         Z/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208039; x=1785812839;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2daEu8V03oHloZq7HOxZbsCrfFEu1YUSaEp/KisdjxA=;
        b=QIV/g/BJAXu6KCJs6CGDBPmg4Q194fUXPAJhn6vO+z+7sOYBH1oGmBvdBBSc11M1sE
         95LJeRThD2pJLvpGZyttCku3ge9WNhZ/zeqYOvb7GOva0gmL0rasvA2kmZfopCr1tu3B
         eyeAXLNgkZY/W6J7NO1WB8NGLOh/CtyOrHYveY0/kU5ByTHxZ90EWFNtmh/YzgUiob+b
         HxHl4lhV/p263qPlu+31brIcQJGqfHLKPflYBBsdXPSMybklXlGEu52rBg9kUn/5C2NJ
         SL/KkG1kKEL3qrBvjK7j9Hn4g2+P0fGWPnrfl7ba0KZ87fY0XFDPHJEL2nunNWH5eDkA
         Mtgw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/El7UJZIOEAA38rC1zMoaLLM3t0fVuxOj5C/kGDdylDgnF3UDWecS9XBeRJ6oTAq6YiSPNcoYUM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTZfcZcNL3nNp5Tt8dR0LogsZ0o3YRcalnsvLzne84w7ZkMJb
	cTBAfAYmoSGsNJdHH3gymMYSYQxBlgxfPAhsGrlA7CW605EuiY9Lf9ix9/d/WfmA
X-Gm-Gg: AR+sD10GvW9Q+kWIGG0MW1x3D4ALmpatW2x3DW1z6YGn27oEx18WBaOFpNLJnwzb3Qu
	RrRlqSPaTJujiMkTp4PiFonAq4ZwRQmfPLWoP8Y79guftdO4xS+WpwiUp9euDnOVzKYM80AGqSm
	heRxl1u8+E2WnuMzYTSstQ1WhkYaqyXxhRSqTVfpOUc8HtfSfCSXniIT4P55ehIPNW2rtVIM3gK
	ObMxuCTGTq8QrmAy63rXBm44wogHSogoQ9Ni0G4Qu96qnIN//SsRLcuwpkRkUk0nFUHQ6flo4G2
	p9ATjeZGUtxCyQ2m91J8E0oEnOIR+Ng9ya1qLuGpuHJHLePZ96xIJaE09HNQ79/UfHM2nFscIhK
	BE48E+HQ4vZawJzpVIWCCueDslWPKUiNqEy08OPePfk8unKt15ErmDAmP7R9qBTk/z7q7pSN2fc
	/dYswMCUOm8AB1yfB5UA==
X-Received: by 2002:a05:6122:3124:b0:5bf:7f98:9657 with SMTP id 71dfb90a1353d-5c33f928744mr246810e0c.6.1785208039161;
        Mon, 27 Jul 2026 20:07:19 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c305759d35sm8148812e0c.18.2026.07.27.20.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:07:18 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [hwmon-next PATCH v3 0/4] hwmon: (adt7470) Add PWM provider and
 thermal sensor support
Date: Tue, 28 Jul 2026 00:07:08 -0300
Message-Id: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANwcaGoC/32Q0U7DMAxFf6XKM0FJWidphRD/gRByG3cNWlpos
 jKY9u9kLdL2gHjzle3je31ikWZPkTXFic20+OinMYvyrmDdgOOOuHdZMyWUFkZqji6ZyojXNNA
 ccP89jcShRimUMtYZxfLm+0y9P67UZzZ8hmnkIx0Te9l68dC+UZcu2Mv04GOa5q/VwiLXnX+vL
 ZIL3nUA1JdAztHTLqDf33dTWC8s6pZh/maozEAAWZkabI/ulnHebM70ccj/SL85AsWI6z+a4mG
 Dqyt8zbthobZUWqx0i/qKfbxEbTESzyL41BQWbPaHskPoayzLUrQVQO2wrSRoEFbnymqVDZ1/A
 L6OxcWoAQAA
X-Change-ID: 20260716-adt7470_thermalzone-59a102278d72
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

The ADT7470 is a temperature monitor and PWM fan controller capable of
monitoring up to ten external temperature sensors and controlling up to
four PWM outputs.

Currently, the driver exposes these sensors and PWM controls only
through the hwmon sysfs interface. This patch series integrates the
ADT7470 driver with the kernel's thermal and PWM subsystems. This allows
temperature sensors to participate in Device Tree thermal zones while
exposing the PWM outputs as generic PWM providers for consumers such as
pwm-fan.

Patch 1 adds the YAML device tree binding documentation.
Patch 2 introduces the ADT7470_PWM_MAX macro.
Patch 3 registers the four PWM channels as a generic PWM provider.
Patch 4 registers the external temperature sensors with the thermal
framework.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

---
Changes in v3:
- Migrated from the `.apply` callback to the PWM Waveform API.
- Moved fixes to another patch series:
  20260727-adt7470_thermalzone-v3-0-21424d550c3d@gmail.com
- Use guard(mutex) for simpler locking.
- Link to v2: https://patch.msgid.link/20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com

Changes in v2:
- Fixed 2 previous bugs uncovered by Sashiko-bot during review.
- Dropped the thermal cooling device registration for the PWM channels.
- Implemented generic PWM provider support using the PWM subsystem.
- Updated Kconfig to safely handle the PWM subsystem dependency (depends on PWM || PWM=n).
- Updated Device Tree bindings to require #pwm-cells instead of #cooling-cells.
- Link to v1: https://patch.msgid.link/20260716-adt7470_thermalzone-v1-0-cc55ef35edde@gmail.com

To: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: Andrew Morton <akpm@linux-foundation.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org

---
Luiz Angelo Daros de Luca (4):
      dt-bindings: hwmon: adi,adt7470
      hwmon: (adt7470) Add ADT7470_PWM_MAX macro
      hwmon: (adt7470) Expose fan control via PWM framework
      hwmon: (adt7470) Add thermal zone sensor support

 .../devicetree/bindings/hwmon/adi,adt7470.yaml     |  55 ++++++++
 drivers/hwmon/Kconfig                              |   1 +
 drivers/hwmon/adt7470.c                            | 146 ++++++++++++++++++++-
 3 files changed, 199 insertions(+), 3 deletions(-)
---
base-commit: 858071a1ca5f9a3330b4559dab41565086ab4862
change-id: 20260716-adt7470_thermalzone-59a102278d72
prerequisite-message-id: <20260727-adt7470_fixes-v2-0-598e38a46ba6@gmail.com>
prerequisite-patch-id: c9bcf1ff38418e47f71472b71dfde900d8d930ec
prerequisite-patch-id: 13a1e87608fe9df25880aa4d1a415aa2dc0b6ffd
prerequisite-patch-id: 01857ee7a1f867a6d415a72f471db5cfef294235
prerequisite-patch-id: 4472685c2096d7d07e580b5d07c37328e0a13ad5
prerequisite-patch-id: 7a40cf8dfb0282f8b7341a1277d4169d8573cb13
prerequisite-patch-id: c8f47ab359354fcc2a7c742adb4b26e3a761bd07
prerequisite-patch-id: 1b37470872d5d5d7795370ceec16e2695894bb44
prerequisite-patch-id: 5ba552f8997854e2f24c3ef005490b5eedcf083f

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>

