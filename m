From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
 find the pwm_backlight
Date: Fri, 20 Jan 2017 11:18:29 +0100
Message-ID: <94d3254b-c658-526d-dd5e-173aad9779c6@redhat.com>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
 <20170120085617.GG4894@ulmo.ba.sec>
 <280ead58-d2c9-f36e-cbfb-90cd7ad5b6f3@redhat.com>
 <1484906109.2133.262.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1484906109.2133.262.camel@linux.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

SGksCgpPbiAyMC0wMS0xNyAxMDo1NSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+IE9uIEZyaSwg
MjAxNy0wMS0yMCBhdCAxMDo0OCArMDEwMCwgSGFucyBkZSBHb2VkZSB3cm90ZToKPj4gSSdtIGZp
bmUgd2l0aCBkb2luZyBhIHYzIHdpdGggYSBjb21tZW50LCBob3cgYWJvdXQgcHV0dGluZyB0aGF0
Cj4+IGNvbW1lbnQKPj4gcmlnaHQgYXQgYWxsIHRoZSBtb2R1bGUqIHN0dWZmIGFuZCBleHBsYWlu
IHRoZXJlIHRoYXQgdGhhdCBpcyB0bwo+PiBzdGF5IGFzIHRoZSBidWlsdGluIG9ubHkgc3RhdHVz
IGlzIG1lYW50IHRvIGJlIHRlbXBvcmFyeSA/Cj4KPiBDYW4gd2UgZG8gb3RoZXIgd2F5IGFyb3Vu
ZD8gSSBtZWFuIHRoYXQgZWl0aGVyIGk5MTUgc2VsZWN0cyBQV01fTFBTUyB0bwo+IGJlIGJ1aWx0
LWluLCBvciB1c2VzIHJlcXVlc3RfbW9kdWxlKCkgY2FsbD8KClBXTV9MUFNTIG5lZWRzIHRvIGJl
IGJ1aWx0LWluIGlmIGVuYWJsZWQsIGEgc3RyaXBwZWQgZG93biBrZXJuZWwKZm9yIG5vbiBjaGVy
cnl0cmFpbCBoYXJkd2FyZSBkb2VzIG5vdCBuZWVkIGl0IC4uLgoKQWxzbyAoYW5kIGVzcCBmb3Ig
cmVxdWVzdF9tb2R1bGUpIHRoaXMgbWVhbnMgYnVpbGRpbmcga25vd2xlZGdlCmludG8gdGhlIGk5
MTUgZHJpdmVyIGFib3V0IHdoaWNoIHB3bSBoYXJkd2FyZSB0aGVyZSBpcyBvbiB3aGljaApib2Fy
ZHMgd2hpY2ggaXMgdW5kZXNpcmFibGUuCgpUaGllcnJ5LCB0aGlzIGRvZXMgZ2l2ZSBtZSBhbiBp
ZGVhIHRob3VnaCwgd2hhdCBpZiB3ZSBleHRlbmQKdGhlIGluZm8gcGFzc2VkIHRvIHB3bV9hZGRf
dGFibGUgd2l0aCBhIG1vZHVsZS1uYW1lIGFuZAptYWtlIHB3bV9nZXQgY2FsbCByZXF1ZXN0X21v
ZHVsZSgpID8KClRoYXQgc2VlbXMgbGlrZSBhIGdvb2Qgc29sdXRpb24gYW5kIHdlIGNvdWxkIHRo
ZW4gYWxzbyBtYWtlClBXTV9DUkMgYSB0cmlzdGF0ZSBhZ2FpbiAoYWZ0ZXIgc29tZW9uZSB3aXRo
IGh3IGFjY2VzcyBoYXMgdGVzdGVkCnRoaXMpLgoKUmVnYXJkcywKCkhhbnMKCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcg
bGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
