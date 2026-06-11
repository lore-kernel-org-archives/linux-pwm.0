Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3C34D901;
	Thu, 11 Jun 2026 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167588; cv=none; b=lF838U78PO3HNUZKxFuU9PCUZ+ztP9/52ZDBPkllVB2MiJ4tiffVaZzJVp5Clut5W1BJuVIcxFFXDHD1xZpyYN7DqrOL34iKMR9Q0pHR8H8URB6yTPn5hUaL4ACcCezOvmrEe0sl/3XrgpIkrXvrqd642KBNpFYFBnA8twRyPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167588; c=relaxed/simple;
	bh=5pvQ8v3SMjwGogRWrF+Ov4Ds5DzEHsb00w0xVEE/07g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ILlaS1bEVta7VEpCgoZqA/79PIDnUEP4j41n/aQiLGiapmF0r80yh8ZiXPEtSJxwxep/qypDojAAwYwsVN9VWfafOOCJgp71h80iwYrl6eazcwhzL23AdpQPhJVfNr1iNfI5Je/hr+v7H1eM2hLsIS57o3af7XOyk22ij3VKbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFQEdgRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFQEdgRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AC41F00893;
	Thu, 11 Jun 2026 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781167587;
	bh=2IIKlhb3svN4EPd89ooG0cnVxCK3GU+JlZ80wFVg5BE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nFQEdgRHCPlaDppgNORMWkZO4wA854yfVwzCTMLEFdNqjtJ7ksYrCCAthGYjPQiGp
	 rpX+y/d8juuDwYat3Rij5nuou/Hbl11diPdFieep+eOn2PNZ2g1rHbJVjnGcKpikwD
	 WyEIv1xUzV0tMHKYIyjEc/T6zO8Z5tSi5tfLRUwMiOhHfXxGl8zQCEh+UFeXkoxh76
	 XNjctmygrPSqtLV9asIrsf0LWuquijaxdu9zAnPg3drK5DTTasjx2Ec4H3OC0bBbQE
	 O0u0wfmfYHMdgxILcA5T3LIglS18amCXgz5SlG5vc25S7WTzNfMw7JEEl6OJpin3ko
	 64l/KQLzvkx0Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, ukleinek@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, linusw@kernel.org, 
 Manish Baing <manishbaing2789@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260523173251.72540-2-manishbaing2789@gmail.com>
References: <20260523173251.72540-2-manishbaing2789@gmail.com>
Subject: Re: (subset) [PATCH v4 1/2] dt-bindings: mfd: st,stmpe: Add
 missing properties for PWM subnode
Message-Id: <178116758438.933112.378885249487702601.b4-ty@b4>
Date: Thu, 11 Jun 2026 09:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sat, 23 May 2026 17:32:50 +0000, Manish Baing wrote:
> The st,stmpe-pwm binding is already covered by the MFD schema in
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. However, the
> PWM subnode was missing a 'required' properties block. This allowed
> Device Tree nodes to pass validation even if the 'compatible'
> string was omitted. This omission could lead to probe failures
> at runtime.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: st,stmpe: Add missing properties for PWM subnode
      commit: b07f7904e0523170856876e4412be852377d492a

--
Lee Jones [李琼斯]

