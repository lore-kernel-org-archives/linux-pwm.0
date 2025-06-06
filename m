Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52844A41;
	Fri,  6 Jun 2025 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168095; cv=none; b=pv+yq6kyWoPFu6VH9iYPh35cQHgGOE7Juoywzin+rxCqZ/5sAnkWvj3JNGs1U0kGE/ei5NrRZIRhiuJC6BevqEslo92wLrzD8JLvKKu9tyR+AAJuFLTQ4/Gv6uoxxXIxzEohfDkhgRGPv65rA4hLDlg+ZaZdDlnAmiIHRSPCcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168095; c=relaxed/simple;
	bh=YuKnegkMnbM4szu+amR2YfzjVvrNlOoFtRS0ECLGqWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiGe9raEuUB9BrpgkhEPBGX4UWB5A9JeWRE8kwvoxQv5IP4u4zDYmfwx2YTbwOOsBJBYjZXWbij0JOzaG1/+v24Ysd2Hy2eDiNpfUsZq52jpJx/5lkllKdRkdPfrMMHTPwE/WWuORi+4QOULWsW607DbuysVYR75LBXUBVmUZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9leJEGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9leJEGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26FC4CEE7;
	Fri,  6 Jun 2025 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749168094;
	bh=YuKnegkMnbM4szu+amR2YfzjVvrNlOoFtRS0ECLGqWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9leJEGqJe0wOxFCdTsvfoKtyzBLIvpbwYCcZI3j7WkZyTG3/gXtPY/Im/bDpfyXS
	 U6gEL/3DjnqIxXB1Bl0Uu+/lCo8eijDnPUiQtpmVQaoDBJ3DHx2+9g2G/OoB4aelkn
	 i0KzVS/zqqPXh9Kjdf+hmF/SEHTVeDPvcQxAdx0wUmy0uNeFpem0eRLXIMQg5H/tUF
	 OCf0ORYBOvHuQRk2fdhprwfqukNvTT/769XhEKtf2gxePeD3aFf4L2R2ivhBKZBvTN
	 /FrhJxF2/ffcK6rjD1H92wJqBxXsTgYy+BrX2tkbL8R6bP8XFXFFAYWQAMKWdwwZqA
	 J5lZiY4wiehPQ==
Date: Thu, 5 Jun 2025 19:01:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pwm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to
 yaml format
Message-ID: <174916809073.3505313.7999310908701889550.robh@kernel.org>
References: <20250602140722.941002-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602140722.941002-1-Frank.Li@nxp.com>


On Mon, 02 Jun 2025 10:07:21 -0400, Frank Li wrote:
> Convert lpc1850-sct-pwm.txt to yaml format.
> 
> Additional changes:
> - add ref pwm.yaml.
> - add resets property to match existed dts.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pwm/lpc1850-sct-pwm.txt          | 20 --------
>  .../bindings/pwm/nxp,lpc1850-sct-pwm.yaml     | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

