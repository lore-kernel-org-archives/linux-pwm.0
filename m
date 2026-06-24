Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F61199EAD;
	Wed, 24 Jun 2026 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324374; cv=none; b=dklZ9rEdZDzU53XLBCDda8cNZLphypR2QqWEevUGNk5Ma7NGOWF8IPjE6wTg+bYePGEQwPSW5ukF2byf90RSJLQc8/TASn97A+lSER+pKOLePbKA+pLaOJUbc+7z2ZCxN8XDdtYjL3RhUm1aKlwvTSoOh0uw3XLoGib83TN7OXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324374; c=relaxed/simple;
	bh=CWV2CodazpVWAzDgOY+6xdyScP/u+sw4Ii7YvacgkJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Z+BtZ2ia00zsJH2JmDgbILpNA9PgfykPtWjQbd3XTZoSoEipm01TtYmGvSXsLpabAeQfYd5tx0SznIqkZ7DRESDJT3FQBkVcYZCF78ir/qI27O4OcqYFPM2NAdmINu00qGT1vfn1at9iNVp+fYaIOG7EwKt+oXPViFA4ZW1CG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGwmU8r2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGwmU8r2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D21F000E9;
	Wed, 24 Jun 2026 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782324373;
	bh=CWV2CodazpVWAzDgOY+6xdyScP/u+sw4Ii7YvacgkJQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=bGwmU8r25CyiS49E2J4yixw3fklzXhkreiNNGZCZJLrHEjUOrLHHgH2HzUKaZXD/T
	 PdlNtWGc0Enj3hv4vYppf//zdQvDwHFs7g919BDTTbB3CDI4HGWEyo0bO9oOcWBbGB
	 A4kzpbRJ6xuyfGyHmcSXFeaZTterFr//fT7MYJNcEONMoPQMdQbSgR0jLp8ay1ezQk
	 4LZ0nwzRg/GFAIykoqSOqUtAdoXecWRq5ceqXxyHwUM00RD5xtmDxnF0Jt+EZ2L9WU
	 mTgrY8NCMIx3VhOO61atxi3U9Wux+gNCIsQOuu09D4VHacGs8X7fNcDJ8iKtoMJLMC
	 5N3MznGMNHk4w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 20:06:06 +0200
Message-Id: <DJHH9AKHNQ3C.3K4CWFQE5P3NU@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-3-dakr@kernel.org>
 <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>
In-Reply-To: <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>

On Wed Jun 24, 2026 at 5:20 PM CEST, Gary Guo wrote:
> This is still unsound, as I mentioned in the last version that the prover=
 must
> be kept.

Heh, I think I just forgot to finish this up, good catch!
