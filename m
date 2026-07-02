Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2E3DC4BC;
	Thu,  2 Jul 2026 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035658; cv=none; b=fq1V2kcSykyB7P3ohfz3ceouuaw/3rI9+fnRPLph31+NvKgtmQ/6/3/oGVpTBuWn/gmEg0Ma7pPGorAweEHVKztXJayQ3JkadOM6S4lm8zhfwK7IdCkwcedSuHIXyNaKoNktBoC+dy4meFhFwnTxTnrJsdGTrDa/TqQsr5leTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035658; c=relaxed/simple;
	bh=52BbPqmqw18QYb4zQynmhqg3NV2jojPQPfsmN69a8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dflmxiww+KuaL/uLtaP46Z697HX8pYx/Ii5grDDuX2UQtEU2UirsER5lhpk2Cw82V0VZFSEQFUTQQwYSjBrMoePEoxvXR6AkVfX3xYE24iPfwIRwp/6vvfKmu4ppGd46gX2+Ku5IFtH3FqqlGT5llcoMyQ5QsMBCs0/OkQeAJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl2Tis5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl2Tis5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8B31F00A3A;
	Thu,  2 Jul 2026 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783035656;
	bh=ls3FCpuFNdNYGB6fMaBWscTranOem0ggKcMVmzo+9lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hl2Tis5bNPiRavztTLfrF8q5jqtC4IWpe8weu9IL0FmM5RPoa669TRFvPceyAgHfC
	 5CUceorA4P06nuO4rXGLf6DllromvNC6UWo42UfD7J7HaJSgZ9wdi//5c7QW1IgfEp
	 VGHN4FpAp5j3L4Pi9TGxmYpMrsa9DDDwYT4VuAdXZDzYnSqd/TPu//2H6DNwSUABwX
	 VRkbmqgKgRvbiy+Oa3Omo9980j23kcu92OjbzwvwcR1yarzbUuCWp7sTZMBSTClBYS
	 nnci7jodlZyucbcRme4Bnwwqc9gDbxj48ZQB0FJNMxDQMO7qZCrGIh4vrwodumPUip
	 n7EjBa4DbAKUQ==
From: Bjorn Andersson <andersson@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Devi Priya <quic_devipriy@quicinc.com>,
	Baruch Siach <baruch.siach@siklu.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH v21 0/6] Add PWM support for IPQ chipsets
Date: Thu,  2 Jul 2026 18:40:30 -0500
Message-ID: <178303563655.359079.10399699991247881677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 06 Apr 2026 22:24:37 +0200, George Moussalem wrote:
> Add PWM driver and binding support for IPQ chipsets.
> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
> ipq9574.
> 
> I've picked up work based on Devi's last submission (v15) which dates
> back to 05 October 2023 as below SoCs are still active.
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: ipq6018: add pwm node
      commit: 6cc812b7435a64cd9d66af107c6dfefb2e77a7cb
[4/6] arm64: dts: qcom: ipq5018: add pwm node
      commit: 4b00afd17a28f44dc63a8602143f84e5f3fa592c
[5/6] arm64: dts: qcom: ipq5332: add pwm node
      commit: 70900a931713888b63c8daec10e708dad1d6e160
[6/6] arm64: dts: qcom: ipq9574: add pwm node
      commit: 35d89e1e12f297b1dce579cbae924e087451acc7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
