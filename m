Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907952;
	b=zIU1K3uRayy7HxTGfcFW0nSeTUX/IrsXoSarTbpc+J3zAG0CVJI/E6danlyt0QVyWovG
	 qK58eMdB9oA9OhNj0geSyOPFk8XZG2luDGS45lT+bhzhlaBM3Sz4MvaLNV6Rdva2Pyeml
	 uL17tqxnw9Y0PmRXNUbUmruhbIhF/+nbBdvBn5P+Uy6aolohzmrTRYkObwivUIQg5TTIP
	 vBXU1lle8V3ldBcv7ukEqS71dh3arR+79luh/+pxQU5DND/0+hJEVWc7xwm7Cznex6KKE
	 PU+8/mKt/HND6aO/0BzARPIijuVQPVeSgVjxv6T7FYqg++TdOOIrKvz8ni9InZjI9iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907952;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7C/Oh2qf22t97UvAJSPDBdguvzEAFhAp3zxPE4qLodQ=;
	b=H4NXgvyQH5yzRZhTRmUrV5WzVwsgFtUIiBcac09sfaF7ykNuUnG/xlyphvsFRzhH0EPm
	 uwKlUgZQgzKlcXKk0EtG84VJPgpdVy99kBdA+r651ktpluFfRzDs08Lgv0mjxJFbLbSmi
	 v49wkkCHvieGyvPGDjYVr+Ptx7pARDJcGh6Sx6Y1KBRzI78LwcCgn0K3OTJyAOjkGqaVn
	 6KunAFHFgiBHqXtkRwX9ZTCsKgwNXo7mfcg/HRsxEf8g5eFemfAWRkoGvKwpcA6KWSQ7R
	 UbQsW1BgYdAjlhkqRN/V122G2jiteo380cF6BzVeHYScjnRnO6aSL73IeAisIR1129Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nR9yABHM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5y93Mj5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673F606A337
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B673F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nR9yABHM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5y93Mj5
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH8lRd71801789
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7C/Oh2qf22t97UvAJSPDBd
	guvzEAFhAp3zxPE4qLodQ=; b=nR9yABHMfzSmZmqLcJddGH5GQ5dbN1wx5/5WPQ
	D1ghVT/+9ScGKQtj/A2fHmTfLaiUa4itv8LXFJGZ6Y3o18yOjQgFt8fFBR04cQsY
	IhT+0LymkO1bltd4jyxUvdKUdRC5QSnokTWcGJmuHww6ub643N52zcYLifMaWdGN
	dgd/d9UzrsgBRlOvpDFnxlFs2VwPsBo1QZqqM2ApVjBePXqV+mekpA0f0RIy+INp
	oRwQAWYS+CzLnnUd/0+RKDR7DU8dFviZb9xZIZjOwFoucBpe016PXrjy9/fFr71P
	3gw60I2vxFkN8iH7kQVVKVtJ+LjSh5v8tcUuttkMML6anwYQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y44hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 09:32:31 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-45eb9967696so760223fac.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Nov 2026 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794907950; x=1795512750; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7C/Oh2qf22t97UvAJSPDBdguvzEAFhAp3zxPE4qLodQ=;
        b=C5y93Mj5WRY/BGJUQQWIHLYfC+f/P/GyxOao4/yrdIqSaCvqPI4f/JGec/efXNbVmR
         goZP6E11uwLn9n+tCJoj+KhaLLw2egztjpDM9TpqMOcZOUWXdl4lBbrwbhHj4NTN04jw
         7n2Hn/bwYy5F1qdK3Xy88E2F3mg0J7bvLj0N0LEfnEVCp1cI7UkRQxwpUtRJW4nxJw/9
         0xCm5MYXtuuTbzuSpYo9Ii09Wi0fI1aUziS2KfiwMZoHlDJJnEQozILq+aAV9JW0aYVj
         wfQeNYxF+J42NH3xtnC8Rv7qochh0kJTJ4ZBLl5VQd6nbGJhrLwlEkOLpGkBeU1vxBVV
         tpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907950; x=1795512750;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7C/Oh2qf22t97UvAJSPDBdguvzEAFhAp3zxPE4qLodQ=;
        b=RlpVCVoyAZSYrpIypo2aDeaekww1VD3CZGhtYiFFk+viMA30eC5g+VyUOMf34TjPDe
         BzbCbXzT9kMWJEswWnTeCEmdNANu6zDMcy1tq+G3ZpDJlFS0dxNdfPrUIqoY54tPQ+id
         U+xbCLXjXN/y0wusAiUySrOtmJKT8IkH04ae5cXTFl9gyKBFZMIRS4wooLVkkkhVkZUd
         f753iG0I817eCvDU2OmYzbUOQ2HpoCls2IvRAdFeUyhnRpQmo6myZApAjqelHSALx/aI
         0BxF7TkWh9ZPimU7M6d9+fZ6dVqqoD/6a/4KOceb5RRUW7EOmFEEupZ757WSTkK3D1y4
         Ag3g==
X-Forwarded-Encrypted: i=1; AL+hErFI4/aO5Z0Is11U8a58p9KiChPfh1DsKZVyL5rqhCV9LtAbG2CDPXjEkfkxBfNzEQIfPARUk0GuVKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SuzRtXR7McD7rAXOj1nFqYBYU/XgP8w+khgjfv+B/ABiBJIlU
	Io+4u04NSUcKiQLRG+tAmQMNfnzOVioeRbK2X1ILbbONflUNBnnvWRRXv1cLpMpIBhazcJgeR7f
	IdO5uBjKHoN79POw3Sco2l+LpbWajWP/L5ohoeVdEMtQmzR79X3SlDTbszoIkBKUE0BO7iexfOQ
	==
X-Gm-Gg: AYBFou2We1xzlFH7Lzp9z/d7brLVV/e8zngKhoO9NjNLttAxt7gd//fFMlIOGmnRdOY
	ne1FA8kuIMTD06VX27n5hZIWN8hKhqwaZdRG7uLJuhX4Oo6r7mj/xhNIqoD2QvM0PUDyqKb/GC5
	ZQMbuA3Kxh/gBIPy1EOFk2MHQj7q7yd/YtFkGYhSmIlcEeX3Hw7THwOdtHOln2izbza0HnKmD4K
	IwwEkUiDgix12uOS3EdE49GoWsW4KpSX1E9gG0XMsMOZka6PFlslVHbONBkfeanuL6siLBAShYw
	Iq2TXC5PCewLvpJVGCIuxcAg8kgx9ZcZJbNiJfKGfsSQALnCq3etHYxzb6ndN2YwdjuPz4qw/b7
	nW496QZBvvE7CK+YfYnwMGJJYtRj0Al6Y5EzssdOhBqvYWN8TRFZDOtUgHiigbo/Iry/eQLwYQ+
	AcH6WujzA1L9GuVDDYMp/9mE+p
X-Received: by 2002:a05:687c:22cb:20b0:4a6:d645:94a9 with SMTP id 586e51a60fabf-4b40afe2b06mr889005fac.4.1794907950007;
        Tue, 17 Nov 2026 01:32:30 -0800 (PST)
X-Received: by 2002:a05:687c:22cb:20b0:4a6:d645:94a9 with SMTP id 586e51a60fabf-4b40afe2b06mr888989fac.4.1794907949550;
        Tue, 17 Nov 2026 01:32:29 -0800 (PST)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2206dc0sm8678928fac.5.2026.11.17.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:32:29 -0800 (PST)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH 0/4] leds: leds-qcom-lpg: Add several fixes and the PWM
 frequency mode support
Date: Tue, 17 Nov 2026 01:31:32 -0800
Message-Id: <20261117-led-qcom-leds-multiple-fixes-and-pwm-fm-support-v1-0-7a862240683f@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAPUe/GoC/yWNQQ7CIBBFr9LM2kmg1Ua9inFBYVAMUGRATZreX
 aq7/5Kf9xZgyo4Yzt0CmV6O3RwbyF0H+q7ijdCZxtCLfpRSDOjJ4FPPYRuMofrikie07kOMKhp
 M74A2INeU5lxwUGJvjwc9iukEzZoy/b5Nern+mev0IF22DKzrF202NFWTAAAA
X-Change-ID: 20261103-led-qcom-leds-multiple-fixes-and-pwm-fm-support-3a04f85c60b9
To: linux-arm-msm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Griffin Kroah-Hartman <griffin@kroah.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907947; l=2405;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=J0/bhp9E9zVhqWsPDFGrCuBfATDpSj5KVBkOOJecmCI=;
 b=B8VIMmvdX0xmus9xtTLOjvBL8GpGgCg9KLaGyJl3DYIe2Csl7x+vjlPejRKLGw32UV7AkFFGw
 x3nbtPfbtYFAl7U6LbY1Jz+ibAdN/uRZRe7fGQnO+NlTKDTXsdhVFTL
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-GUID: eN3vCfIT6L6TD4tu2JS3bmxOwgv9O20x
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afc1f2f cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=UvHhfY28hrIE04vzKvkA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: eN3vCfIT6L6TD4tu2JS3bmxOwgv9O20x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXyo0D1DqLxqLZ
 NpCRpSpzoFfv1joXNeucqaVQaCZk/qj1DSUEFKXt7uTvfkoQbV0eLbK9dOxsRaWLlsIXF1DSznH
 VlJDNHQMr+XhnGCPFpIDunAWggnEWec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXxizGqG2b2V+W
 4RhfkqCzYtHxLGljp0qN0jlmxaZLmpM8gMs4g3NOvJIyQ2tNmzABDUV6mWzaaxuC3/VtcRYx0Xy
 DmdHJwXMlpG8c/7Ome2Tg1WqqWs6Mro2+fnJTM4lX6AYev8boiQrKEiEsty8OlOTmoZRzi1JSeu
 rTPrTfh2lotdzDb7Hk+4Vbm2hgR/E632qQCKK09SFF9735A3XCyBAAqp2boB3xoKJnart6u9TRj
 nHCNwhgdMt/kTUhgDehVegCkuHjyQoO/Yz0vep5KLZ1KXZVX3fBVPL+PVuBHdP75oB+FaUS7jXl
 73LNBVBJ2ZEJpM6zR1l9TaUvKtywPOsjyFVjylY0WfvI+nK/TF4ixRD+Hrpxj5baUo/Y0b1Y+Wp
 y+BEoKEfWpCYfx7gdye5+wA6J1+dqwOIEVfNrLTYavvtvX171TJz8msgogvfAGSnyuZEC7N23Ej
 a9jgLreJDL9SEwax+ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170037

This series of changes combines and rebased these 2 series as they were
changing the same driver file. It is easier to send them together to handle
the dependency:

https://lore.kernel.org/linux-leds/20260716-lpg-rgb-color-balance-fix-v6-1-b49d51528f61@oss.qualcomm.com/
https://lore.kernel.org/linux-leds/20260827-lpg-pwm-fm-support-v3-1-88ae5208c57b@oss.qualcomm.com/

Also, a new change is added to close the discussion in here:
https://lore.kernel.org/linux-leds/20260827133753.GM770273@google.com/

Following are the Changes in this series after the combination:

- Added changes to scale the pattern when the brightness and
  multi_intensity is updated while the pattern is active.
- Added a new change for explicit LUT ownership tracking to fix single-entry
  LUT leaks during pattern cleanup.
- Skipped LUT allocation for zero-intensity multicolor channels to fix
  comments from Konrad.
- Renamed Frequency Mode identifiers consistently from `fm_*`/`frequency_mode`
  to `freq_mode_*', and clean up the code and fix the naming issues to address
  the review comments from Lee.
- Added logic to compare the timing accuracy between standard pwm mode and
  frequency mode and select the better one.

The change series was tested on Maili QRD device with pmh0101 in these scenarios:
1. Tested the RGB LEDs by randomly adjusting the brightness, hw_pattern, and
   multi_intensity when it is working in HW pattern mode, and the LED pattern
   and color were confirmed to update correctly every time.
2. Exercised the PWM4 channel on pmh0101 by requesting it at different periods
   with a 50% duty cycle, confirming that the frequency mode could be configured
   correctly.
 

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Fenglin Wu (4):
      leds: rgb: leds-qcom-lpg: Fix single-entry LUT leak
      leds: rgb: leds-qcom-lpg: Fix LED color balancing in HW pattern mode
      leds: rgb: leds-qcom-lpg: add mutex lock in lpg_pwm_get_state()
      leds: rgb: leds-qcom-lpg: Add PWM frequency mode support

 drivers/leds/rgb/leds-qcom-lpg.c | 643 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 562 insertions(+), 81 deletions(-)
---
base-commit: 4e88404a72e5e26720539e5555c383069cefb486
change-id: 20261103-led-qcom-leds-multiple-fixes-and-pwm-fm-support-3a04f85c60b9

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

