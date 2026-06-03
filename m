Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCA2D7DD4;
	Wed,  3 Jun 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449028; cv=none; b=OZzMKszVszP/tQ0Kt6wYfW43J2j9B3ooVNidfWhSJ+aWl9uNeS3PvngyfCCJ6k/xIz/hreo+vpfaICdStWA9Y8q/gjX/jaauT2+Fd3aq9OpSS3l3viLyPM2wtvjo3P5Mzq3U/BUK196kSWbgtZESRY2n80ain/8+TAdgcdZ3hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449028; c=relaxed/simple;
	bh=VFJzEinoo/4V280HpZpXwl1kty1kGVWTjct7kNh18nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFzz0KIMviltWif40vAvQolCTbDzS13z2K4UiYboTygdcXcjni2VhpzAF/BgROQZw0OMqAx8OZ91/8hnmEJCMo4b9H834kUP+W9JJsGQN4VUIaMYJsqi9xXEm8uf4rKP7ipsfahXmvcmq/DwFyPQnEVOTI7qgpyFa+oC27O11uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK40Chfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK40Chfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B2A1F00893;
	Wed,  3 Jun 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449027;
	bh=vg4OT7qVOOfiZWFV5Vcsuizp9IDFD8+pqun6oZHSTcM=;
	h=From:To:Cc:Subject:Date;
	b=bK40Chfx+OYTbVFoho2VApu/zYarNWFjOtFjO7yjtr8tQILFmaHSzBTcATrsQ5lOt
	 BzzDNGMelyIeLbDps5lE25YcnmL4lOYemVseUghlhimjykx9sBLUxO/LVIuSL5TfNs
	 /WQnxYsAq1fscjQsNbEJcqZ0vTlc7b0aNghVgTWJLDxqJEOaw9TQDel7YZUsuO3J/U
	 xsIDlEF8LylAtjBaClr+Snzq5QWNI8rrwO3FZocJauVvMtXjo/U1dOYTfN61eJf06J
	 id3S68G+VgFIL2GjMBROGyqe855oW7lPLcRhPVROkwQt06aDl4mcPl/Df8zgTSm7Ry
	 MwU62cK2I0z0Q==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
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
	kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt
Date: Wed,  3 Jun 2026 03:10:11 +0200
Message-ID: <20260603011020.2073650-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ForLt trait currently guarantees covariance, which allows safe
lifetime shortening via cast_ref(). However, some types (e.g. those
containing Mutex<&'bound T>) are invariant over their lifetime parameter
and cannot safely use cast_ref().

This series splits ForLt into two traits:

  - ForLt: base trait providing unsafe cast_ref_unchecked() for all
    lifetime-parameterized types.

  - CovariantForLt: unsafe subtrait that guarantees covariance,
    providing a safe cast_ref() method.

For invariant types, a closure-based API (registration_data_with()) is
added to the auxiliary subsystem. The closure's HRTB prevents the caller
from choosing a concrete lifetime, which would be unsound for invariant
types.

On top of that, this series adds DevresLt<F: ForLt>, a thin wrapper
around Devres<F::Of<'static>> that shortens the stored 'static lifetime
back to the caller's borrow scope. DevresLt provides both closure-based
access (access_with/try_access_with for ForLt types) and direct
reference access (access/try_access for CovariantForLt types).

Also implement ForLt and CovariantForLt for Bar, IoMem and
ExclusiveIoMem, and update their into_devres() methods to return
DevresLt. Provide convenience type aliases DevresBar, DevresIoMem and
DevresExclusiveIoMem.

Changes in v2:
- Fold the ForLt -> CovariantForLt rename and the new ForLt base trait
  into this series
- Add closure-based registration_data_with() for auxiliary ForLt types
- Add auxiliary sample demonstrating ForLt with an invariant Mutex type
- DevresLt: add closure-based access_with()/try_access_with() for ForLt
  types alongside direct access()/try_access() for CovariantForLt types
- Make DevresLt::new() unsafe; callers must guarantee the data outlives
  the device binding
- Implement both ForLt and CovariantForLt (previously just ForLt) for
  Bar, IoMem, ExclusiveIoMem
- Various safety comment and documentation improvements

Danilo Krummrich (7):
  rust: types: rename ForLt to CovariantForLt
  rust: types: introduce ForLt base trait for CovariantForLt
  rust: auxiliary: add registration_data_with() for ForLt types
  rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
  rust: devres: add DevresLt for ForLt-aware device resource access
  rust: pci: return DevresLt from Bar::into_devres()
  rust: io: mem: return DevresLt from
    IoMem/ExclusiveIoMem::into_devres()

 drivers/gpu/nova-core/driver.rs       |   4 +-
 drivers/pwm/pwm_th1520.rs             |   5 +-
 rust/kernel/auxiliary.rs              |  74 +++++++++++++---
 rust/kernel/devres.rs                 | 110 +++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++-----
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 +++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           | 122 ++++++++++++++++++++------
 rust/macros/for_lt.rs                 |  52 ++++++++---
 rust/macros/lib.rs                    |  18 +++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++------
 12 files changed, 472 insertions(+), 113 deletions(-)


base-commit: 0023a1e8d01a9d400257d30c851bd16a29568809
-- 
2.54.0

