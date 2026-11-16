Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812943;
	b=MfsUJNsZHIUQsBLGiF6KA73nvs2oJYrA05cwMPtezXhCFAg4BQwgRjDjHZpLg86izXMs
	 C5q7KEoZGoIBOKP1cnd77D1/7wytcVEiF8Zfl5e/zIEE0Wm2Ews3La2tyhKMQ37L4iRGb
	 SGe88h4aEYHWsOSfrEL9bMKCEEkhfgFLldYh33u9qhRINOmxx15qzX3dQxhY57FcRICuc
	 keKn3CDt1Q0KYIT9bs1/6sH1ZXCIhZZ2Oo4VrcWZCZGDsNXLCSebwB6I6gt2odlHdHj5L
	 2SdJOxuSyvszgCfxbsnPvt0NcdRDcSCrbRKs8fKFiFNlApm+kdvGLdnOINVEuNw6PPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812943;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9WdwW0PxcdlHIuh6wsyIMEhMeQ2NP8tLx3e3xYrc0iQ=;
	b=Wb/vC4mJblWkpgwdBEnCBcdIU9NpqqCLlLA5SbrFZ8vIWziIDnmFk3j20D0BFeBRA50S
	 4x3S43ziBTYPd80BBfLWxyWG1wOPMBjNeRUDCNv9wnpOpCAcJZcw3/055wP11fODcF6DF
	 DZUhd/YbDx/9h8D84dNYG/LtPJKXH21O0le1CJ8rWL+8oVcNpMn3D6vFQveSrAEmlF1Gr
	 ZMv28Hp5GSm5ZZgb60ba5zg+9GxXBzR89/dqFAL7X9/YmKdUvxMSKT5X20g8vQF6R7uk5
	 zUzKVfT9pt9kFIqQdoohwdEhLhJbFALnQYjTy6MgCClulW3XQ39poMxpcdLxfP/d0mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZH8MeQs9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=edWR+TJ7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB0606A32C
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BB0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZH8MeQs9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=edWR+TJ7
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG5Lish112173
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9WdwW0PxcdlHIuh6wsyIMEhMeQ2NP8tLx3e3xYrc0iQ=; b=ZH8MeQs97Jn+Nz7j
	oQXiHB4IkGURaQ8uD+A1xpdIhyqr3dFJIZKT4L7kqlPig5xoeR6JA0r/asWKYhJB
	D5jFdJuSbWoN15p31ZxK6Ssl/n1l9zmxe4JOXL34RTNZit1nGG1bzZG0xRSRpGYa
	7Bh/vGGSPgv/8OqLb7eluzdXznsvZ0FDTfaGMPczh/zTq7mmNidU/xrcNYzmjVFc
	ghixAsQypLshPo03XZNCxZsdlOqq6TI3kqTH87dUI+FgxB6gUMvCEF8eJS8owS1P
	CHwMQMF2wJDd/cAmu5BXC6IAuv/xvbMNpDN1U3/jnJlvjQaZqq+Ji6kl0sgf9a2y
	yv72GA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwd79h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 07:09:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed02a00b24so27323595ad.2
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 23:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794812941; x=1795417741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WdwW0PxcdlHIuh6wsyIMEhMeQ2NP8tLx3e3xYrc0iQ=;
        b=edWR+TJ7BkxF99l6V7m24S/Y5lqvWA+S6/1v8YrYnBqvwHOVRr9bd2S54ESoceHamS
         CB5r8ZBXTSJwuvzRm8JY4MP7ySwOdOU0ud9S5bB269YVyokgSvLBU4EA11lvMIClzjKk
         vBZ4Q/aMEXqG9JLkX2WDzJoBu2g9t0ieOrsE5yTXc0dJ+XE62ippT+LxWcJ1ron20JgN
         YdV0QznlbpOHVXEYcBD6Ki/g1TYL7J1XgiIikDtpD+BAjlHLqLUPTuIPBZ92j6m2P00s
         b7HAW+AxFaGNQ135E4femHepm1lM2GWn0/fQEahJy6Ogho897Vew3ch6iTNkTlRYpJUy
         z+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812941; x=1795417741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WdwW0PxcdlHIuh6wsyIMEhMeQ2NP8tLx3e3xYrc0iQ=;
        b=qoNHnhEohDUldU1cPpOd13npRtbcxwDRyO9WLgYZhCeCoFsFEWg2Co47/+UUx8rRVc
         a3fuU9Ww1S2HpAOcpBVxioM2lh3TZSXzWRgpwPoaewyzb0tRkM4TMWSShFo2YjTNijJT
         hIHu5JJf9Hj2V6J11MRUhUOnnLQ28vCHo13jomXDkx3WWUSPMywZiOxLTGgKOLmUmj9h
         VjidMVMCoNTIKQapqrSALxOCIvaF021Gzcgb4yY8HRe7LM7VGZiyl1Ea7hp9tAOnHOa8
         HeOi9LZynVMwBrLmmI4qMWP4Y1WbX15KgDXg6TnZVy5vbaHFCE7snoAF64D0ETukDgg1
         Q+7w==
X-Forwarded-Encrypted: i=1; AL+hErF3H/014B7IMpt/GRngnDFI1SR68wPIWrP5Zf+T9VPxDkHq3MdtTKmesW8gNOLs9mMDrQvnfqAUio4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RejZ1/LF7MhM3WRBcdnQ1NbqWimbMTq2rmkB5oZhWlcTBT0j8
	5ejag+sdTb1x/wmXxv0qDV9Wjj5fASNkjCoAdhifRDOU0RJYS33iY+yil7u0lRuS7C3Uo+iYhy4
	zOnKBPAW9gbWp9/NH2yQOwh7cbOuXXnP4OyGoWT0+dl2OI3houBNEwiy4MtMn01o=
X-Gm-Gg: AZFdTZemkWzkB74LJEV1EukOIsZOmT18GNngtlqQKA3zh9jjA7xWU0UfVwL9rvDGZCo
	74PGqZFbwaqlo7xaLDhHA1krkkfIdnNN9vR/QhN9JAfyzppo7ao21iPRbgTVxkDhSuCYo2Y9HRL
	IKX+wEDAlVaJWir6550M0XSJklkuDWAi3XST8Te9F4sgiTmtdyNIpiWd+9FinqkzcIc2+QMPWyG
	Yx18I2Z7n5JJ0Cxx5i73Vfze0QaCbM3gC1J5PY3PUraW18d3VUEMt8wv9cCxFa2WwY+xibk34id
	TPgYoYyG+vr6fKV+8On+UduC1PP13uJ7n2rR2cnXqBgsqAQ/uMwaFRL84uLT01h8cv5gKqcZo6I
	xH/bZJktvWSW7ajrVTtRVS2iSC3LR6M28bXp3V6z4/v2xm3f/iSdIsAj3ORZqNuCb+m2D0pKdgg
	==
X-Received: by 2002:a17:90b:184d:b0:3b1:6cab:f68b with SMTP id 98e67ed59e1d1-3b1b0a0e8dcmr8498742a91.11.1794812941404;
        Sun, 15 Nov 2026 23:09:01 -0800 (PST)
X-Received: by 2002:a17:90b:184d:b0:3b1:6cab:f68b with SMTP id 98e67ed59e1d1-3b1b0a0e8dcmr8498723a91.11.1794812940978;
        Sun, 15 Nov 2026 23:09:00 -0800 (PST)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm8658667a91.0.2026.11.15.23.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:09:00 -0800 (PST)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:29:50 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: add Shikra PWM controller
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
Message-Id: <20261116-pwm_qcom_shikra-v1-3-67ee4553adc5@oss.qualcomm.com>
References: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
In-Reply-To: <20261116-pwm_qcom_shikra-v1-0-67ee4553adc5@oss.qualcomm.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfX0FaEv90Enapq
 418iEV6y2rYlUityWnfoxMh2GypWBe7o/Ua+7nHkL6Yxn4Ic0dIxkI4SGh/qY13CZVehTOVk1QQ
 SYbfKs2JcOg0WtJ+60QGZ9XBaY0Wsb+WfsmTZX6m0LcSjqDGZ65XJ456YkDm9Jkp5fop1sWCqyV
 aTjRV84V2qv7XvnkTE8d3oMnwiZzH2P2kmqdDIglQ6VF1wEDDEX1+8f3/W/xktfg5Rjk5shVdux
 scgXg4KZWmyvV5fHvmSyiQQMeDK/UH1aB+T+ELkSPqGTEV2U01c/Czu6MYA8qMzqMJ42rRkOR8F
 C9FSATMxPgCfj7kw060iA1e2Y4e98h4PbVhVlQEVyCLwFmmblRtc4/HaG5E0Eg41v0x5DisBTjy
 /VuElfnJoMEHjroMs1zv8qRh1e4X4Yj5Ic5txq3r6VSxqZUdriiotL42AQmRcnLEiRpP74nZTN3
 KPKSZ0YdP80/BgB+Rgg==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6afaac0e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jcq69FRwgK9YgyupxYoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: w7uJWTS3QKk5TglX-P6BwCfT9eO5RYcw
X-Proofpoint-ORIG-GUID: w7uJWTS3QKk5TglX-P6BwCfT9eO5RYcw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyOCBTYWx0ZWRfX2iWBpCNXadqz
 63kEqSpVFx0rWWCGuslmzeaF6dtW1Sfk8sRabh8zD3LZITri7hSmyyFl/IpAp7FgscODPWhw+zJ
 nLArZph5o1LsFjB+fVwoubR4BP4tYoA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160028

Add the PWM controller node with its AHB and core clocks and the ten
PWM frame child nodes to the Shikra SoC DTSI. Assign the shared PWM
core clock a rate of 9.6MHz.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 0a95ad5a5582c643f97e2b0725eb88a9f262d83c..d8a3de38382bdb00684acd709f4d34136792771c 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1303,6 +1303,69 @@ sram@4690000 {
 			reg = <0x0 0x04690000 0x0 0x14000>;
 		};
 
+		pwm: pwm@4700000 {
+			compatible = "qcom,shikra-pwm";
+			reg = <0x0 0x04700000 0x0 0x10>;
+			clocks = <&gcc GCC_PDM_AHB_CLK>, <&gcc GCC_PWM0_XO512_CLK>;
+			clock-names = "ahb", "core";
+			assigned-clocks = <&gcc GCC_PWM0_XO512_CLK>;
+			assigned-clock-rates = <9600000>;
+			#pwm-cells = <3>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			pwm@4701000 {
+				reg = <0x0 0x04701000 0x0 0x1c>;
+				qcom,frame-index = <0>;
+			};
+
+			pwm@4702000 {
+				reg = <0x0 0x04702000 0x0 0x1c>;
+				qcom,frame-index = <1>;
+			};
+
+			pwm@4703000 {
+				reg = <0x0 0x04703000 0x0 0x1c>;
+				qcom,frame-index = <2>;
+			};
+
+			pwm@4704000 {
+				reg = <0x0 0x04704000 0x0 0x1c>;
+				qcom,frame-index = <3>;
+			};
+
+			pwm@4705000 {
+				reg = <0x0 0x04705000 0x0 0x1c>;
+				qcom,frame-index = <4>;
+			};
+
+			pwm@4706000 {
+				reg = <0x0 0x04706000 0x0 0x1c>;
+				qcom,frame-index = <5>;
+			};
+
+			pwm@4707000 {
+				reg = <0x0 0x04707000 0x0 0x1c>;
+				qcom,frame-index = <6>;
+			};
+
+			pwm@4708000 {
+				reg = <0x0 0x04708000 0x0 0x1c>;
+				qcom,frame-index = <7>;
+			};
+
+			pwm@4709000 {
+				reg = <0x0 0x04709000 0x0 0x1c>;
+				qcom,frame-index = <8>;
+			};
+
+			pwm@470a000 {
+				reg = <0x0 0x0470a000 0x0 0x1c>;
+				qcom,frame-index = <9>;
+			};
+		};
+
 		sdhc_1: mmc@4744000 {
 			compatible = "qcom,shikra-sdhci", "qcom,sdhci-msm-v5";
 

-- 
2.34.1

