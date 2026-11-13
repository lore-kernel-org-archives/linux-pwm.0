Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601538;
	b=cTLdRfDWFZLkeHZoQIR9FmQHaH1kOFOTBkRpeY3XF+AdDuvFswlvECxQI9n6n432YBKr
	 KMbw0ZCKDSky4/iO/CnUX8R0wwVvxsudibVhc8PGZ26oU38xNuf9tBen7Z1IQ5JClzNJ1
	 VlGNs4dSmAGECeUmt1wtDaxa6mNfBorw+xI12jzMxDVSrI5xg52zmq9YI+J6+PK9Z1Vm7
	 57wQTCXol21g/3P9eWP2bHJCditjoBm4Lzx8alGQRJ7a6ZYZhsrOoVjS6zPnG1W7IXGIV
	 a338iWmptvXxQyFrOkRGuGX3aiJ9nPxva6JVeD7VDjumhe495Ck+3wb4VWEEpQS2HBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=59ejQt0DZ682CJ3qOErWLZhd2Fb+1az71At2oyBOpNo=;
	b=xH3rX75D2aOQT9ivlDVK8dcNA3QAzzs6lUFpBkx5YgS65c+0Sx1VptTIxxQAds/PgdZv
	 VgKa3Hn2tg44OQqLc3h3eekbk5QCfLrmVlRfjwKUOnBqjgUnu2O9PYZFNqggRGbM1etz/
	 z33BRg7diYLnXBpWWCj/Fz7R3DrQDIlJWFxVMKse0exIRCo05jTEf5xMZ6UVP33YOgNh6
	 PfQvsMWHsvgZuQqe7IqFt3wJfNrYJ93nktDq201wGxBiy4tboVk/fn2CSNhRVdmYIN+Ym
	 qnecOFuz8pdGB2R5TOzLrxO5ifTenVOGob4xq2gwrVK4ZJYhmfwWFkOfliTkuh1N5Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uci.edu;
	spf=pass smtp.mailfrom=uci.edu;
	dkim=pass header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=R2pdk0m9;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3534606A332
	for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2026 20:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3534606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=uci.edu header.i=@uci.edu header.a=rsa-sha256 header.s=google header.b=R2pdk0m9
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1780311eec.0
        for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2026 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1794601537; x=1795206337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59ejQt0DZ682CJ3qOErWLZhd2Fb+1az71At2oyBOpNo=;
        b=R2pdk0m9kctP99lTTCcUlW7Q/p0IaEYnhMhVMKpcSUAmvdgecgofqnlnQshCkMOCwk
         5TrxSkqpE8m9PCuYycabJIzmHiO5hMh+6CeAncYZXL75zyAIUUB1zGJ/GS5Wn3ZH9RyP
         UARSbPODbtoREItc9uH1efrlwGikktSd4DQ67VAhPvW8M2oxOGELMGfDJkbn9vgM1GGw
         5ujosY7urM1T352ijFf59hYPNvLapK5htf5ISPoF4W9ScXIgjpr/bJUZJD5YmCqq+q0D
         sXXM7PGR/Oi9bYUzQsNh0Kjo0/tSsVnqdTrMNdclXEx1L8TUDpp9sKFkXiSdmCneohyC
         EyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601537; x=1795206337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=59ejQt0DZ682CJ3qOErWLZhd2Fb+1az71At2oyBOpNo=;
        b=RZwhJKdqDWVVeo/gYpKSsfK4u5Wlra21PJHNUuE7/FrzEiyy7n1CsEettd91asR7fR
         BqP6ZOLvDFRHFQTE2SiZiU/CRjUJDPJnb6C8FcDGbRFQy6kjiYWYIhGooTZMMX64eHX0
         eFTbviLT8oAM9KZUXfBpKx/yVjTY06TYGb1de+rkydv2S9hrh6vs1cf4P7q+3IdZggwH
         oF5nmrYYWfnYB/yK4DM7WIWBM16yZbXQCBCN3DQPbFrPgePcDItot2zCGmNnHa8QUExS
         HBNmxMbjFLYb4nPSXsf27IYb7+1RojSlTNW7uDzvGBVp8AqL8wQ6PApX63uXv5WkpQuP
         mVLw==
X-Forwarded-Encrypted: i=1; AL+hErHZZJgG7nVQDmQ60Ere/B/YCigOB8GGZ1heoN4ojZyotC9lD+QXn2Vu+df2qXVYOLPip2XHJr0hxns=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fmcpT2KBtc97LDbGG2QE/TYhu/dtP2oPYYntDrHixMG6O8pRB
	+0z7l6XqMP55eiKOHox8wkUkXk4Y9/16PJE+CzgI1HPmPHmB0dHCpHWktNL/85JkGF8=
X-Gm-Gg: AYBFou1Y7h3eIEAQ9mmOdk2haxWJfbVjhRlNAxXqWJyDqeUjYKTUbCuUvlegaOu8VDo
	NYRp9NWELCKqXH7ATENPKgPUABjv7Ie4hru6/oX91RzbrMXm0KTQxEDZb+ja418acJmHPD9Mil7
	ASx4X9p2LCNrQPTYPfKpdXMDtpOUkZgfsf6qKM6UfsXj0CEiDxSEykYoqbWPKpk7rcBBBkShf+u
	8ed15aNo4RUB0B34vo8GrzOSXZHtpXDB8JqWo2oNSDtbZQ7Cn6/mcVYpcFfZPwnmQG8HtYwAH1X
	kiUBthqu9X67Yuwbn5KHLEeIaxEb5whnRuodD/jhF3gEKP/ftGk22FcLMFDXaYQAWJp7/BzyS7K
	FlMJAdx7jkrikyRKY7PvHdShr1tsCra3YqxX8fJddyU5fNh10oFatK4QJoy7dzcWGK0OHmC26Xp
	KbsFVrK0f91GEN7FDakGnRZhPHV4tIqhVzyGgi8ho/wysE3vfR2TwYYYG4DR0QvLHuXssNuWWW6
	qT4uUDpl80CJpL59CEyociPDzqtjhynRDTxv3JhAuwLs6HemVbPPd08f7U3BN7lj0cP/xsXOSxd
	xSF4S/BvzouQcvzM+TKDst/jFf3MCZE4Ym6B4vzwNjswcN0ZKof6heEizYuYZyto4x2kPdtmX+o
	ui2YC6cVauOajvDI=
X-Received: by 2002:a05:7301:90b:b0:34d:755b:d60b with SMTP id 5a478bee46e88-37968b8a031mr2946772eec.34.1794601536671;
        Fri, 13 Nov 2026 12:25:36 -0800 (PST)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-37956bad134sm11725372eec.27.2026.11.13.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:25:36 -0800 (PST)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: m.wilczynski@samsung.com,
	ojeda@kernel.org,
	ukleinek@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	elle@weathered-steel.dev,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 0/1] rust: pwm: reject over-aligned driver data in `Chip::new()`
Date: Fri, 13 Nov 2026 20:25:33 +0000
Message-Id: <cover.1794600927.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux kernel maintainers,

We are developing a tool called FerroLens to detect potential
unsound behavior in Rust code in the Linux kernel. The tool
internally uses an LLM to detect bugs.
We then perform manual analysis to verify these reports.
FerroLens reported the following bug in rust/kernel/pwm.rs:

`Chip::new()` does not check the alignment of the driver data type `T`.
This allows a Rust kernel module to choose an arbitrary alignment for `T`.

`pwmchip_alloc()` reserves `size_of::<T>()` bytes for the driver's
private data. `pwmchip_priv()` aligns this storage to `PWMCHIP_ALIGN`,
which is defined as `ARCH_DMA_MINALIGN`. But, `PwmOps` does not restrict
the alignment of `T`, so a caller may provide a `T` whose required
alignment is greater than `ARCH_DMA_MINALIGN`.

This can result in `drvdata_ptr` pointing to misaligned storage for `T`
in the underlying C allocation.
If `drvdata_ptr` is misaligned for `T`, that breaks the safety
requirements of `pin_init::raw_try_init()` which requires a valid,
aligned pointer as an argument. This is undefined behavior.

Additionally, `Chip::drvdata()` can be called using the `Chip` produced by
`Chip::new()`. It creates a reference to `T` from the misaligned storage
which is also undefined behavior.

Here is a PoC kernel module that demonstrates this issue:

    // SPDX-License-Identifier: GPL-2.0

    use kernel::{prelude::*, pwm, faux};
    use core::ptr;

    module! {
        type: PwmAlignPoc,
        name: "pwm_align_poc",
        authors: ["Priya Govindasamy"],
        description: "PoC that calls pwm::Chip::new with a PwmOps implementation that has unexpected alignment",
        license: "GPL",
        imports_ns: ["PWM"],
    }

    #[repr(align(8192))]
    #[pin_data]
    struct DemoPwmOps {
        #[pin]
        value: u64,
    }

    impl pwm::PwmOps for DemoPwmOps {
        type WfHw = [u8; 16];
    }

    struct PwmAlignPoc{
        _fdev: faux::Registration,
    }

    const DEVICE_NAME: &CStr = c"pwmchip_add_poc";

    impl kernel::Module for PwmAlignPoc {
        fn init(_module: &'static ThisModule) -> Result<Self> {
            pr_info!("pwm-align-poc: init\n");

            let fdev = faux::Registration::new(DEVICE_NAME, None)?;
            let dev = fdev.as_ref().as_ref();

            let chip = pwm::Chip::new(
                dev,
                1,
                try_pin_init!(DemoPwmOps {
                    value: 0x1122_3344_5566_7788,
                }),
            )?;

            pr_info!("pwm-align-poc: pwm::Chip::new returned successfully\n");

            let chip_ref: &pwm::Chip<DemoPwmOps> = &*chip;
            let drvdata = chip_ref.drvdata();

            let drvdata_addr = ptr::from_ref(drvdata) as usize;

            let align = core::mem::align_of::<DemoPwmOps>();
            let size = core::mem::size_of::<DemoPwmOps>();
            let misalignment = (drvdata_addr as usize) & (align - 1);

            pr_info!(
                "pwm-align-poc: T size={} align={} drvdata={:#x} drvdata%align={:#x}\n",
                size,
                align,
                drvdata_addr as usize,
                misalignment,
            );

            if misalignment != 0 {
                pr_info!("pwm-align-poc: BUG: drvdata is not aligned for DemoPwmOps\n");
            } else {
                pr_info!("pwm-align-poc: drvdata happened to be aligned; try reloading or increasing repr(align)\n");
            }

            drop(chip);

            Ok(Self { _fdev: fdev })
        }
    }

    impl Drop for PwmAlignPoc {
        fn drop(&mut self) {
            pr_info!("pwm-align-poc: exit\n");
        }
    }



Output:

[935472.295875] pwm_align_poc: pwm-align-poc: init
[935472.300101] pwm_align_poc: pwm-align-poc: pwm::Chip::new returned successfully
[935472.300125] rust_kernel: panicked at rust/kernel/pwm.rs:561:18:
                misaligned pointer dereference: address must be a multiple of 0x2000 but is 0xffff88811a9bc8a8
[935472.300296] ------------[ cut here ]------------
[935472.300302] kernel BUG at rust/helpers/bug.c:7!
[935472.300357] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
[935472.321291] CPU: 11 UID: 0 PID: 168877 Comm: insmod Tainted: G           OE    N   7.3.0+ #71 PREEMPT(lazy) 
[935472.326767] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [N]=TEST
[935472.330167] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu2 04/01/2014
[935472.335684] RIP: 0010:rust_helper_BUG+0x8/0x10
[935472.338311] Code: ff 5d c3 cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[935472.348377] RSP: 0018:ffff888163fe7610 EFLAGS: 00010282
[935472.351153] RAX: 0000000000000092 RBX: ffff888163fe7638 RCX: 79d6f1f055ce0500
[935472.355104] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff85cb7348
[935472.359054] RBP: ffff888163fe7610 R08: ffffffff85cb734b R09: 1ffffffff0b96e69
[935472.365925] R10: dffffc0000000000 R11: fffffbfff0b96e6a R12: ffff88811a9bc8a8
[935472.369831] R13: ffff88811a9bc8a8 R14: dffffc0000000000 R15: ffff88811a9bc000
[935472.373766] FS:  00007fb90f158c40(0000) GS:ffff88842697a000(0000) knlGS:0000000000000000
[935472.377958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[935472.380839] CR2: 00007f2817fd91ac CR3: 000000010c31e004 CR4: 0000000000372ef0
[935472.384553] Call Trace:
[935472.385839]  <TASK>
[935472.386965]  _RNvCsGIExRX8pES_7___rustc17rust_begin_unwind+0x8c/0x90
[935472.390092]  ? __pfx__RNvXs6_NtCsbuTvttuFvbr_6kernel3fmtINtB5_7AdapterRRNtNtNtCsjYlAz7NZ3Sw_4core5panic10panic_info9PanicInfoENtNtBS_3fmt7Display3fmtB7_+0x10/0x10
[935472.396837]  _RNvNtCsjYlAz7NZ3Sw_4core9panicking18panic_nounwind_fmt+0x5e/0x5e
[935472.400208]  _RNvNtCsjYlAz7NZ3Sw_4core9panicking36panic_misaligned_pointer_dereference+0x90/0x91
[935472.404082]  ? __pfx__RNvXsC_NtNtCsjYlAz7NZ3Sw_4core3fmt3numyNtB7_8LowerHex3fmt+0x10/0x10
[935472.407670]  ? __pfx__RNvXsC_NtNtCsjYlAz7NZ3Sw_4core3fmt3numyNtB7_8LowerHex3fmt+0x10/0x10
[935472.411102]  _RNvXs_CsiYPS3iQo6vD_13pwm_align_pocNtB4_11PwmAlignPocNtNtCsbuTvttuFvbr_6kernel6module6Module4init+0x599/0x5d0 [pwm_align_poc]
[935472.416147]  ? debug_smp_processor_id+0x1b/0x30
[935472.418137]  init_module+0x15/0xff0 [pwm_align_poc]
[935472.420132]  do_one_initcall+0x119/0x4f0
[935472.421738]  ? __pfx_init_module+0x10/0x10 [pwm_align_poc]
[935472.423926]  ? __schedule+0x171a/0x5910
[935472.425480]  ? __x64_sys_finit_module+0x7f/0x90
[935472.427411]  ? __lock_acquire+0xeeb/0x1040
[935472.429044]  ? debug_smp_processor_id+0x1b/0x30
[935472.430831]  ? irqentry_exit+0x1e1/0x870
[935472.432174]  ? __this_cpu_preempt_check+0x17/0x20
[935472.434047]  ? lockdep_hardirqs_on+0xdc/0x160
[935472.435746]  ? trace_hardirqs_on+0x3d/0x50
[935472.437405]  ? irqentry_exit+0x1e1/0x870
[935472.438833]  ? trace_irq_disable+0x3c/0x130
[935472.440421]  ? sysvec_apic_timer_interrupt+0x68/0xd0
[935472.442163]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[935472.444092]  ? _RNvNvNtCsjYlAz7NZ3Sw_4core4hint21unreachable_unchecked18precondition_check+0x30/0x30 [pwm_align_poc]
[935472.447576]  ? __pfx_init_module+0x10/0x10 [pwm_align_poc]
[935472.449472]  do_init_module+0x23f/0x740
[935472.450781]  load_module+0x32d1/0x3f20
[935472.452116]  __se_sys_finit_module+0x39d/0x5f0
[935472.453645]  __x64_sys_finit_module+0x7f/0x90
[935472.455093]  x64_sys_call+0xa66/0x2600
[935472.456370]  do_syscall_64+0x11c/0x3f0
[935472.457696]  ? do_syscall_64+0x217/0x3f0
[935472.459046]  ? debug_smp_processor_id+0x1b/0x30
[935472.460488]  ? rcu_is_watching+0x1a/0xc0
[935472.461701]  ? trace_irq_disable+0x3c/0x130
[935472.463044]  ? do_syscall_64+0x6d/0x3f0
[935472.464254]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[935472.465663]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[935472.467238] RIP: 0033:0x7fb90e91e9dd
[935472.468444] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 b4 0f 00 f7 d8 64 89 01 48
[935472.473776] RSP: 002b:00007ffd3d6cabb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[935472.476032] RAX: ffffffffffffffda RBX: 0000559f8e9df7d0 RCX: 00007fb90e91e9dd
[935472.478187] RDX: 0000000000000000 RSI: 0000559f772fecd2 RDI: 0000000000000003
[935472.480301] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[935472.482103] R10: 0000000000000003 R11: 0000000000000246 R12: 0000559f772fecd2
[935472.484269] R13: 0000559f8e9df790 R14: 0000559f772fd888 R15: 0000559f8e9df8e0
[935472.486330]  </TASK>
[935472.487082] Modules linked in: pwm_align_poc(OE+) registration_poc(OE) binfmt_misc intel_rapl_msr intel_rapl_common kvm_intel kvm e1000 i2c_piix4 joydev i2c_smbus floppy rapl qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 aesni_intel gf128mul input_leds psmouse mac_hid serio_raw pata_acpi
[935472.498241] ---[ end trace 0000000000000000 ]---
[935472.499836] RIP: 0010:rust_helper_BUG+0x8/0x10
[935472.499845] Code: ff 5d c3 cc cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[935472.499849] RSP: 0018:ffff888163fe7610 EFLAGS: 00010282
[935472.499865] RAX: 0000000000000092 RBX: ffff888163fe7638 RCX: 79d6f1f055ce0500
[935472.499868] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff85cb7348
[935472.499871] RBP: ffff888163fe7610 R08: ffffffff85cb734b R09: 1ffffffff0b96e69
[935472.499874] R10: dffffc0000000000 R11: fffffbfff0b96e6a R12: ffff88811a9bc8a8
[935472.499876] R13: ffff88811a9bc8a8 R14: dffffc0000000000 R15: ffff88811a9bc000
[935472.499879] FS:  00007fb90f158c40(0000) GS:ffff88842697a000(0000) knlGS:0000000000000000
[935472.499882] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[935472.499885] CR2: 00007f2817fd91ac CR3: 000000010c31e004 CR4: 0000000000372ef0

Priya Bala Govindasamy (1):
  rust: pwm: reject over-aligned driver data in `Chip::new()`

 rust/bindgen_parameters         | 1 +
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/pwm.rs              | 5 +++++
 3 files changed, 7 insertions(+)

-- 
2.34.1

