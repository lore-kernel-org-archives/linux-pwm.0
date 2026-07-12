Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AD10F1;
	Sun, 12 Jul 2026 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783814881; cv=none; b=roglW1oo+R5KnQ9aazV8SWyuPsh7HX/Yjpa/tWeG95ggGgYuAbYNIQlQeGss0H43W+HUsQz2zWlXxP+W8KO04Ph1MpnQSLyoqC+2iuMIlkes2XuwNBsfJhuXUh1OBmj3BeCl8X9cjXD6Bm4s40BUMY/u6WUrG1tJBH+ugxVH4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783814881; c=relaxed/simple;
	bh=Epcr+6QTKGexCO60FWug52aA9oJGY38Tk4ijWPeqjHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG/PDNy41LaYw9UPcls07rEo3kM6RB9ayrGElujoyW4D0T9EhGu9h1GcM7yCj/fz0pduLQwTnw3aQnYvI6gzr1eZdabj0xnAdnI0Pa5CCiU5RRy4fw12Z2Hoq/rpqA+3xxpLPNxZV4iGlxfbPszNIKUAA/QmPtVgObciWBcSDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5SWi+hF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5SWi+hF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084891F000E9;
	Sun, 12 Jul 2026 00:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783814880;
	bh=ttgZInexN3hBBgwLbtnF4oTV34tO3wrwFS76SfDUJdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5SWi+hFTQYmZK96ZeOkuaP58ZPKDKqRb0r3g3ok0mZjX/unGMJng2mIqq19Aoeqd
	 wyM9jUfIYPsl2T1yEW9hRGnwbalsQXFUgeRI3pMJWyYIyhm9iLBVKMkhpbSemU9B20
	 ZSYSkKD6Wb+TTkYtf9fSpD1xB4Z/8Cw/+GeDuAyiBhEQLzM33jxtEaZAuQM1gEo8ak
	 +FpazN01QDRXCq1b+x27XlVX2tG5zLLvKs7RfiZ/grZng/+9sFSyZN4gVVAlR4aBll
	 mqmXdaee6/OAnPW8GwqudeACohryNO8NRsWyEShSxXM5tXNpUgTOiMBLAjzEEyXi6N
	 72+HzdUlSPHvw==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	ecourtney@nvidia.com,
	m.wilczynski@samsung.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	daniel.almeida@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt
Date: Sun, 12 Jul 2026 02:07:51 +0200
Message-ID: <20260712000751.749981-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 20:36:07 +0200, Danilo Krummrich wrote:
> [PATCH v4 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt

Applied, thanks!

  Branch: topic/dd-lifetimes
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/7] rust: types: rename ForLt to CovariantForLt
      commit: 2c91f57e81a7
[2/7] rust: types: introduce ForLt base trait for CovariantForLt
      commit: 1b56056294d4

      [ Merge ForLt pub use, inline resolve_hrt/ty_static, add intra-doc
        links. - Danilo ]

[3/7] rust: auxiliary: add registration_data_with() for ForLt types
      commit: 491784c54cc1
[4/7] rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
      commit: 6763c8876d2a
[5/7] rust: devres: add DevresLt for ForLt-aware device resource access
      commit: b85f672a3e68
[6/7] rust: pci: return DevresLt from Bar::into_devres()
      commit: e7e6bf5af80e

      [ Add default SIZE parameter to DevresBar. - Danilo ]

[7/7] rust: io: mem: return DevresLt from IoMem/ExclusiveIoMem::into_devres()
      commit: 7488dc14b05a

      [ Add default SIZE parameter to DevresIoMem. - Danilo ]

The patches are in the topic/dd-lifetimes topic branch and will be merged into
the corresponding target branch soon.
