Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F33890E8;
	Wed, 13 May 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715235; cv=none; b=CUtLCI5VbQP8zk8zwucQO3yl806juGXU+Ec3I6nSsAjtspaUtFBb+3HPSkP59KhyGzms0mRtPmadUIud244KHGSzBAihsbKe+Phv+z8NS92YW5mAo9a3HJSTO7lXVoGbm9VbL49TVAPphx7BKlyjo9e25z55/Uzhym39FujypGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715235; c=relaxed/simple;
	bh=ABN00HzQ91S9l2mJfmg1rfw+l+o9zTlnJwwutFGLwM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM51qa9f3Uw/lm7ZPOgK83hIpzewHXKFsWukUrQ4nr0e/mm6DnpxR/sD60aDJeTzH9QQylYjykq7f1T0VaWTnsNnaBRIep/RS5N6fM+GB65JU5E13/MDpUTp7IdOQ7sN9Gn70YxEvR05JzECpOxyOsi4QB6LyaDIgE8wxr7z1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK6GldL0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK6GldL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1579C19425;
	Wed, 13 May 2026 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715235;
	bh=ABN00HzQ91S9l2mJfmg1rfw+l+o9zTlnJwwutFGLwM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK6GldL0bTZVqO9OPG1ev4S3c6qMvI//wfjvKk1rZ0j69abHr9hqNO7J9Mmt6n1+o
	 PdcPGN4X7wQ80RoyXo7u+OyrlnH+PCPkf9aXiN2kXqioWMnyINK3deRFbSUoo9/1X9
	 QwOTMFJQmxv+qWAqU686nn9BgSd0m8dQCdoPNOG3TuLdb5wMD4oUjzlZhz/brJsFFb
	 WaIopn7fsArYBuXAaxdgUaZptS4nQuvEJvxbMazt2Sr71IRgyhSQx7MlEQ9PMIbCHG
	 SgUrYj5yJuLmVI7EzcBTPgoZTGFf0WDFPFBuLZP3+5/7RotCIq7KhKu76iOJbBZsPF
	 b56EUDkUpi8Ww==
Date: Wed, 13 May 2026 18:33:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	ukleinek@kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linusw@kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: stmpe: drop legacy binding
Message-ID: <177871523137.2307220.3066863194193334549.robh@kernel.org>
References: <20260508184626.15938-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508184626.15938-1-manishbaing2789@gmail.com>


On Fri, 08 May 2026 18:46:26 +0000, Manish Baing wrote:
> The st,stmpe-pwm binding is already covered by the MFD schema
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. Remove the
> obsolete and redundant text binding file.
> 
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> ---
> Changes in v2:
> - Drop the TXT file instead of converting to YAML, as the
>   functionality is already covered by st,stmpe.yaml.
> - Update the commit subject and description to reflect the drop.
> 
>  .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

