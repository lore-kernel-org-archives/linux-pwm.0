Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Tue, 20 Nov 2018 21:29:45 +0100
Message-Id: <20181120202945.24100-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH] [RFC] Documentation: pwm: rework documentation for the
 framework
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

This is a draft for an in my eyes improved documentation describing
consumers, providers and backend drivers of the PWM framework.

The bigger changes include:

 - sysfs description is split into a separate document (otherwise unchanged)
 - Only the new style functions and callbacks are described; the legacy
   stuff is just mentioned shortly in a dedicated paragraph.
 - The expectations for the different callbacks (most importantly .apply)
   are mentioned explicitly.

There is a gap in the documentation because I didn't understand the
.capture callback. There is no documentation about it, just two drivers
implementing it. I guess it is about measuring an input signal, so it seems
to be misplaced in the PWM framework which otherwise is just about an
output pin.

Not-yet-signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is my try to better document the expectations and requirements of
the PWM framework. I expect that there is nothing where I disagree with
Thierry here.

Some things I think are worth changing yet are:

 - move .owner from struct pwm_ops to struct pwm_chip. This is better
   located there IMHO and it can be automatically set by making
   pwmchip_add a macro similar to spi_register_driver so drivers can
   stop caring about that.
 - drop .capture?
 - maybe warn if a legacy-driver is used in pwm_get to make people aware
   there is work to be done?

Best regards
Uwe

 Documentation/pwm-sysfs.txt |  44 +++++++
 Documentation/pwm.txt       | 229 +++++++++++++++---------------------
 2 files changed, 138 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/pwm-sysfs.txt

diff --git a/Documentation/pwm-sysfs.txt b/Documentation/pwm-sysfs.txt
new file mode 100644
index 000000000000..e7da67940648
--- /dev/null
+++ b/Documentation/pwm-sysfs.txt
@@ -0,0 +1,44 @@
+Using PWMs with the sysfs interface
+-----------------------------------
+
+If CONFIG_SYSFS is enabled in your kernel configuration a simple sysfs
+interface is provided to use the PWMs from userspace. It is exposed at
+/sys/class/pwm/. Each probed PWM controller/chip will be exported as
+pwmchipN, where N is the base of the PWM chip. Inside the directory you
+will find:
+
+  npwm
+    The number of PWM channels this chip supports (read-only).
+
+  export
+    Exports a PWM channel for use with sysfs (write-only).
+
+  unexport
+   Unexports a PWM channel from sysfs (write-only).
+
+The PWM channels are numbered using a per-chip index from 0 to npwm-1.
+
+When a PWM channel is exported a pwmX directory will be created in the
+pwmchipN directory it is associated with, where X is the number of the
+channel that was exported. The following properties will then be available:
+
+  period
+    The total period of the PWM signal (read/write).
+    Value is in nanoseconds and is the sum of the active and inactive
+    time of the PWM.
+
+  duty_cycle
+    The active time of the PWM signal (read/write).
+    Value is in nanoseconds and must be less than the period.
+
+  polarity
+    Changes the polarity of the PWM signal (read/write).
+    Writes to this property only work if the PWM chip supports changing
+    the polarity. The polarity can only be changed if the PWM is not
+    enabled. Value is the string "normal" or "inversed".
+
+  enable
+    Enable/disable the PWM signal (read/write).
+
+	- 0 - disabled
+	- 1 - enabled
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..b97508ce1510 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -11,148 +11,107 @@ found as discrete devices on SoCs which have no fixed purpose. It's
 up to the board designer to connect them to LEDs or fans. To provide
 this kind of flexibility the generic PWM API exists.
 
-Identifying PWMs
-----------------
+PWM consumers
+-------------
 
-Users of the legacy PWM API use unique IDs to refer to PWM devices.
+A driver (e.g. for a backlight or a fan) first needs to "get" a PWM device
+using the function pwm_get() or devm_pwm_get().
+These return an opaque handle to a certain hardware PWM that can be used to
+configure the respective PWM. The relevant function is
 
-Instead of referring to a PWM device via its unique ID, board setup code
-should instead register a static mapping that can be used to match PWM
-consumers to providers, as given in the following example::
+	int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
 
-	static struct pwm_lookup board_pwm_lookup[] = {
-		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight", NULL,
-			   50000, PWM_POLARITY_NORMAL),
-	};
+This API controls both the PWM period/duty_cycle config, polarity and the
+enable/disable state. The usual way to use pwm_apply_state() is in combination
+with pwm_get_state() like:
 
-	static void __init board_init(void)
-	{
-		...
-		pwm_add_table(board_pwm_lookup, ARRAY_SIZE(board_pwm_lookup));
-		...
-	}
+	pwm_get_state(pwm, &state);
+	state.duty_cycle = 0;
+	pwm_apply_state(pwm, &state);
 
-Using PWMs
-----------
+When the PWM isn't needed any more, drop the handle using pwm_put() after
+disabling the PWM.
 
-Legacy users can request a PWM device using pwm_request() and free it
-after usage with pwm_free().
+PWM providers
+-------------
 
-New users should use the pwm_get() function and pass to it the consumer
-device or a consumer name. pwm_put() is used to free the PWM device. Managed
-variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
+There are two canonical ways to provide one or several PWMs: device tree and
+board code.
 
-After being requested, a PWM has to be configured using::
+For the former it is enough to register a PWM chip using pwmchip_add() with the
+pwm_chip's .dev member pointing to the providing device. pwm_get then yields
+references to this chip when the device passed to pwm_get has pwm handles
+according to Documentation/devicetree/bindings/pwm/pwm.txt.
 
-	int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
+In board code you can register a pwm lookup table that is then used to satisfy
+pwm_get requests by consumers. See the documentation of pwm_add_table() for
+details.
+
+PWM implementers
+----------------
 
-This API controls both the PWM period/duty_cycle config and the
-enable/disable state.
-
-The pwm_config(), pwm_enable() and pwm_disable() functions are just wrappers
-around pwm_apply_state() and should not be used if the user wants to change
-several parameter at once. For example, if you see pwm_config() and
-pwm_{enable,disable}() calls in the same function, this probably means you
-should switch to pwm_apply_state().
-
-The PWM user API also allows one to query the PWM state with pwm_get_state().
-
-In addition to the PWM state, the PWM API also exposes PWM arguments, which
-are the reference PWM config one should use on this PWM.
-PWM arguments are usually platform-specific and allows the PWM user to only
-care about dutycycle relatively to the full period (like, duty = 50% of the
-period). struct pwm_args contains 2 fields (period and polarity) and should
-be used to set the initial PWM config (usually done in the probe function
-of the PWM user). PWM arguments are retrieved with pwm_get_args().
-
-Using PWMs with the sysfs interface
------------------------------------
-
-If CONFIG_SYSFS is enabled in your kernel configuration a simple sysfs
-interface is provided to use the PWMs from userspace. It is exposed at
-/sys/class/pwm/. Each probed PWM controller/chip will be exported as
-pwmchipN, where N is the base of the PWM chip. Inside the directory you
-will find:
-
-  npwm
-    The number of PWM channels this chip supports (read-only).
-
-  export
-    Exports a PWM channel for use with sysfs (write-only).
-
-  unexport
-   Unexports a PWM channel from sysfs (write-only).
-
-The PWM channels are numbered using a per-chip index from 0 to npwm-1.
-
-When a PWM channel is exported a pwmX directory will be created in the
-pwmchipN directory it is associated with, where X is the number of the
-channel that was exported. The following properties will then be available:
-
-  period
-    The total period of the PWM signal (read/write).
-    Value is in nanoseconds and is the sum of the active and inactive
-    time of the PWM.
-
-  duty_cycle
-    The active time of the PWM signal (read/write).
-    Value is in nanoseconds and must be less than the period.
-
-  polarity
-    Changes the polarity of the PWM signal (read/write).
-    Writes to this property only work if the PWM chip supports changing
-    the polarity. The polarity can only be changed if the PWM is not
-    enabled. Value is the string "normal" or "inversed".
-
-  enable
-    Enable/disable the PWM signal (read/write).
-
-	- 0 - disabled
-	- 1 - enabled
-
-Implementing a PWM driver
--------------------------
-
-Currently there are two ways to implement pwm drivers. Traditionally
-there only has been the barebone API meaning that each driver has
-to implement the pwm_*() functions itself. This means that it's impossible
-to have multiple PWM drivers in the system. For this reason it's mandatory
-for new drivers to use the generic PWM framework.
-
-A new PWM controller/chip can be added using pwmchip_add() and removed
-again with pwmchip_remove(). pwmchip_add() takes a filled in struct
-pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provided by the chip and the chip-specific
-implementation of the supported PWM operations to the framework.
-
-When implementing polarity support in a PWM driver, make sure to respect the
-signal conventions in the PWM framework. By definition, normal polarity
-characterizes a signal starts high for the duration of the duty cycle and
-goes low for the remainder of the period. Conversely, a signal with inversed
-polarity starts low for the duration of the duty cycle and goes high for the
-remainder of the period.
-
-Drivers are encouraged to implement ->apply() instead of the legacy
-->enable(), ->disable() and ->config() methods. Doing that should provide
-atomicity in the PWM config workflow, which is required when the PWM controls
-a critical device (like a regulator).
-
-The implementation of ->get_state() (a method used to retrieve initial PWM
-state) is also encouraged for the same reason: letting the PWM user know
-about the current PWM state would allow him to avoid glitches.
-
-Locking
--------
-
-The PWM core list manipulations are protected by a mutex, so pwm_request()
-and pwm_free() may not be called from an atomic context. Currently the
-PWM core does not enforce any locking to pwm_enable(), pwm_disable() and
-pwm_config(), so the calling context is currently driver specific. This
-is an issue derived from the former barebone API and should be fixed soon.
-
-Helpers
--------
-
-Currently a PWM can only be configured with period_ns and duty_ns. For several
-use cases freq_hz and duty_percent might be better. Instead of calculating
-this in your driver please consider adding appropriate helpers to the framework.
+The main task a pwm hardware driver has to complete is to provide a struct
+pwm_chip and register it using pwmchip_add().
+
+The following members have to be provided:
+
+ - .dev: Pointer to the device that provides the PWMs
+ - .ops: Callbacks for hardware access. The only function callback that is
+   required is .apply which is the back-end for pwm_apply_state(). See below
+   for more details.
+ - .base: integer ID of the first pwm provided by this chip. Usually you want
+   to pass a negative number here, then this ID is allocated dynamically. Apart
+   from legacy usage the base has only internal semantics providing a unique
+   identification for each PWM. (Note this is only a hint and might be modified
+   on registration.)
+ - .npwm: number of PWMs provided by this chip.
+
+Optionally you can provide a function callback .of_xlate that is used for
+device tree lookups. If not provided of_pwm_simple_xlate() is used implementing
+the lookup as described in the generic pwm dt binding.
+
+The .ops structure allows to define the following callbacks:
+
+ - .request: Optional function that is called on pwm_get(). When this function
+   returns a non-zero value this results in pwm_get() failing.
+ - .free: Counterpart to .request called from pwm_put().
+ - .capture: XXX this is unclear to me. Is this a consumer of a remote PWM
+   signal? Then this has nothing to do with the intend of the PWM framework and
+   should better be dropped?
+ - .apply: depending on the passed state the following behaviour is expected to
+   be implemented:
+
+   All state changes should only be effective after the currently running
+   period (if any) is completed. For a disabled pwm they can and should be
+   effective immediately.
+
+   If state->enabled is false, the values state->period and state->duty_cycle
+   are ignored and the output must be ensured to be inactive (that is
+   constant low if state->polarity == PWM_POLARITY_NORMAL, or constant high if
+   state->polarity == PWM_POLARITY_INVERSED).
+
+   If state->enabled is true, the output must be configured to run in periods of
+   length state->period nanoseconds. For each period the output should be active
+   (i.e. high if state->polarity == PWM_POLARITY_NORMAL, low otherwise) during
+   the first state->duty_cycle nanoseconds of each period and inactive for the
+   rest of it.
+
+   When the .apply callback returns to the caller the newly configured state
+   should already be active.
+
+   .apply is the only place where the output wave is supposed to be changed. All
+   other functions should not modify the configured state.
+
+ - .get_state: Optional function that should read the configuration from the
+   hardware and fill the provided state variable accordingly.
+ - .owner should be initialized to THIS_MODULE.
+
+Legacy Usage
+------------
+
+The PWM API evolved in the past and not all users are converted yet. To get
+hands on a PWM device you might see code using pwm_request (and pwm_free to
+dispose it). Also for the different configuration possibilities there used to be
+pwm_config/pwm_set_polarity/pwm_enable/pwm_disable. struct pwm_ops still
+contains the matching callbacks that are still used if provided. New usage of
+all these functions is discouraged.
-- 
2.19.1
